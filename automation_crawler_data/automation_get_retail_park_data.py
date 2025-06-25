from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

driver = webdriver.Chrome()


driver.get("https://completelyretail.co.uk/portfolio")


cards = driver.find_elements(By.CLASS_NAME, "portfolios_Card__jbTpg")
print(f"Found {len(cards)} card(s).")


def get_listing_addresses(driver):
    # Find elements with class 'result_CardComponent__82ZMN'
    listing_data_details = driver.find_elements(By.CLASS_NAME, "result_CardComponent__82ZMN")
    results = []
    for listing in listing_data_details:
        try:
            address = listing.find_element(By.TAG_NAME, "address")
            address_text = address.get_attribute("title")
        except Exception:
            address_text = "No address found"
        try:
            property_type = listing.find_element(By.CLASS_NAME, "result_propertyType__ad1iK").text
        except Exception:
            property_type = "No property type found"
        try:
            agent_contact_elem = listing.find_element(By.CLASS_NAME, "result_agentContainer__rfUFP")
            agent_contact = agent_contact_elem.text
        except Exception:
            agent_contact = "No contact information available"
        results.append({
            "address": address_text,
            "property_type": property_type,
            "agent_contact": agent_contact.replace(chr(10), ' ')
        })
    return results

details = []

for i in range(len(cards)):
    try:
        cards = driver.find_elements(By.CLASS_NAME, "portfolios_Card__jbTpg")
        card = cards[i]
        
        card.click()
        print(f"Clicking card {i + 1}...")
        time.sleep(2)

        filtered_elements = driver.find_elements(By.CLASS_NAME, "categorise_PortfolioCard__n3Mfs")
        for j in range(len(filtered_elements)):
            try:
                filtered_elements = driver.find_elements(By.CLASS_NAME, "categorise_PortfolioCard__n3Mfs")
                filtered_element = filtered_elements[j]
                filtered_element.click()
                print(f"  Clicked filtered element {j + 1} in card {i + 1}")
                time.sleep(4)
                
                # Get all pagination links (if any)
                pagination_links = driver.find_elements(By.CSS_SELECTOR, ".search_resultsHeader__41ltE .pagination_Inner__NbFU5 .pagination_link__2eJ32")
                page_numbers = [link for link in pagination_links if link.text.isdigit()]
                
                if page_numbers:
                    for idx, page_link in enumerate(page_numbers):
                        try:
                        # Re-find pagination links each time due to DOM changes after click
                            pagination_links = driver.find_elements(By.CSS_SELECTOR, ".search_resultsHeader__41ltE .pagination_Inner__NbFU5 .pagination_link__2eJ32")
                            page_link = [l for l in pagination_links if l.text.isdigit()][idx]
                            try:
                                page_link.click()
                            except Exception:
                                driver.execute_script("arguments[0].click();", page_link)
                            time.sleep(5)
                            list_details = get_listing_addresses(driver)
                            if list_details:
                                details.extend(list_details)
                            if idx == 0:
                                print("  This is the first page, no need to go back.")
                            else:
                                driver.back()
                                time.sleep(4)
                        except Exception as e:
                            print(f"    Could not click page {idx + 1}: {e}")
                else:
                    list_details = get_listing_addresses(driver)
                    if list_details:
                        details.extend(list_details)
                    time.sleep(4)

                driver.back()
                time.sleep(4)
            except Exception as e:
                print(f"  Could not click filtered element {j + 1} in card {i + 1}: {e}")
        
        driver.back()
        time.sleep(2)

    except Exception as e:
        print(f"Could not click card {i + 1}: {e}")

# eport details to CSV
import csv
with open('retail_park_data.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['address', 'property_type', 'agent_contact']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for detail in details:
        writer.writerow(detail)

time.sleep(2)

driver.quit()

