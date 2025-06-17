ALTER DATABASE [BusinessIntelligenceBankPark] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BusinessIntelligenceBankPark].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ARITHABORT OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
--ALTER DATABASE [BusinessIntelligenceBankPark] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET READ_COMMITTED_SNAPSHOT OFF 
GO
--ALTER DATABASE [BusinessIntelligenceBankPark] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET RECOVERY FULL 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET  MULTI_USER 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET PAGE_VERIFY CHECKSUM  
GO
--ALTER DATABASE [BusinessIntelligenceBankPark] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET QUERY_STORE = ON
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1024, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200)
GO
USE [BusinessIntelligenceBankPark]
GO
/****** Object:  Schema [Dashboarding]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Dashboarding]
GO
/****** Object:  Schema [development]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [development]
GO
/****** Object:  Schema [eCam]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [eCam]
GO
/****** Object:  Schema [KPI]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [KPI]
GO
/****** Object:  Schema [Litigation]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Litigation]
GO
/****** Object:  Schema [Monday]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Monday]
GO
/****** Object:  Schema [NPED]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [NPED]
GO
/****** Object:  Schema [OLAP]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [OLAP]
GO
/****** Object:  Schema [Reporting]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Reporting]
GO
/****** Object:  Schema [Statistics]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Statistics]
GO
/****** Object:  Schema [Test]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE SCHEMA [Test]
GO

/****** Object:  Table [Statistics].[Client_StaffVehicles]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Client_StaffVehicles](
	[SiteID] [bigint] NULL,
	[VRM] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Sites_ZoneActiveServices]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Sites_ZoneActiveServices](
	[ZoneID] [bigint] IDENTITY(1,1) NOT NULL,
	[ZoneExternalReference] [int] NULL,
	[ANPR] [bit] NULL,
	[ANPRLiveDate] [date] NULL,
	[ANPRTermDate] [date] NULL,
	[PARKING OPS] [bit] NULL,
	[PPSLiveDate] [date] NULL,
	[PPSTermDate] [date] NULL,
	[STS] [bit] NULL,
	[STSLiveDate] [date] NULL,
	[STSTermDate] [date] NULL,
	[ITICKET] [bit] NULL,
	[ITICKETLiveDate] [date] NULL,
	[ITICKETTermDate] [date] NULL,
	[CONTRAVENTION MANAGEMENT] [bit] NULL,
	[CMLiveDate] [date] NULL,
	[CMTermDate] [date] NULL,
	[OTHER] [bit] NULL,
	[OtherLiveDate] [date] NULL,
	[OtherTermDate] [date] NULL,
	[ECAM] [bit] NULL,
	[eCamLiveDate] [date] NULL,
	[eCamTermDate] [date] NULL,
	[IPARK] [int] NULL,
	[iParkLiveDate] [date] NULL,
	[iParkTermDate] [date] NULL,
	[ITICKETLITE] [int] NULL,
	[ITICKETLITELiveDate] [date] NULL,
	[ITICKETLITETermDate] [date] NULL,
	[STSNEW] [int] NULL,
	[STSNewLiveDate] [date] NULL,
	[STSNEWTermDate] [date] NULL,
 CONSTRAINT [PK__Sites_Zo__60166795DC419E32] PRIMARY KEY CLUSTERED 
(
	[ZoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_Issued]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_Issued](
	[ContraventionID] [bigint] NOT NULL,
	[ContraventionNumber] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionDate] [datetime] NULL,
	[SiteReference] [int] NULL,
	[SiteName] [nvarchar](255) NULL,
	[ServiceType] [nvarchar](50) NULL,
	[DateIssued] [date] NULL,
	[StellaOrExtranet] [bit] NULL,
	[ContraventionTime] [time](7) NULL,
	[TimeIssued] [time](7) NULL,
	[ContraventionHour] [time](7) NULL,
	[HourIssued] [time](7) NULL,
	[WardenID] [bigint] NULL,
	[ContraventionReason] [nvarchar](255) NULL,
	[Service_type_prefix] [int] NULL,
	[ContraventionStatus] [nvarchar](30) NULL,
	[IsForeignPlate] [bit] NULL,
	[NTKDate] [date] NULL,
	[Jurisdiction] [int] NULL,
 CONSTRAINT [PK_Contraventions_Issued] PRIMARY KEY CLUSTERED 
(
	[ContraventionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Wardens]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Wardens](
	[WardenID] [int] NOT NULL,
	[WardenExternalID] [nvarchar](20) NULL,
	[WardenName] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](100) NULL,
	[Postcode] [nvarchar](100) NULL,
	[ContractHours] [nvarchar](10) NULL,
	[StartDate] [date] NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[StellaOrExtranet] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_Cancellations]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_Cancellations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[LocationName] [nvarchar](255) NULL,
	[ZoneName] [nvarchar](255) NULL,
	[LocationPostcode] [nvarchar](50) NULL,
	[LocationLongitude] [decimal](12, 9) NULL,
	[LocationLatitude] [decimal](12, 9) NULL,
	[WardenName] [nvarchar](255) NULL,
	[WardenRegion] [nvarchar](100) NULL,
	[WardenSubRegion] [nvarchar](100) NULL,
	[ContraventionNumber] [bigint] NULL,
	[FirstIssuedDate] [date] NULL,
	[CancelledDate] [date] NULL,
	[CancelledByUser] [nvarchar](100) NULL,
	[KeyAccountManager] [nvarchar](150) NULL,
	[ServiceType] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
	[CancelledReason] [nvarchar](255) NULL,
	[YearCancelled] [int] NULL,
	[MonthCancelled] [nvarchar](20) NULL,
	[SiteID] [int] NULL,
	[ContraventionReason] [nvarchar](200) NULL,
	[ExtranetOrStella] [bit] NULL,
	[CancellationGroup] [nvarchar](100) NULL,
	[LocationId] [int] NULL,
	[ZoneId] [int] NULL,
	[VRN] [nvarchar](100) NULL,
	[ContraventionDate] [datetime] NULL,
 CONSTRAINT [PK_Cancellations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_PaidTransactions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_PaidTransactions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[PaymentDate] [date] NULL,
	[PaidAmount] [decimal](10, 2) NULL,
	[ExtranetOrStella] [bit] NULL,
	[IsPaidDirect] [bit] NULL,
	[IsFinalPayment] [bit] NULL,
	[MostRecentTransaction] [bit] NULL,
	[ServiceType] [nvarchar](50) NULL,
	[SiteID] [int] NULL,
	[ServiceTypePrefix] [int] NULL,
	[ContraventionDate] [datetime] NULL,
	[ContraventionNumber] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_DvlaKadoeRequests]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_DvlaKadoeRequests](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[ContraventionNumber] [bigint] NULL,
	[DVLASentDate] [date] NULL,
	[DVLAReturnedDate] [date] NULL,
	[ReturnStatusCode] [nvarchar](200) NULL,
	[DVLAStatus] [nvarchar](50) NULL,
	[ServiceTypePrefix] [int] NULL,
	[ExternalReference] [int] NULL,
	[DateIssued] [date] NULL,
 CONSTRAINT [PK__Contrave__3214EC2703B182D0] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[Departments]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[Departments](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Deleted] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Dashboarding].[ANPR_eCam_DailyMetrics]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dashboarding].[ANPR_eCam_DailyMetrics](
	[MetricID] [bigint] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[MovementsCreated] [int] NULL,
	[MatchesCreated] [int] NULL,
	[ANPR_OverstaysCreated] [int] NULL,
	[ANPR_VerificationsCreated] [int] NULL,
	[eCam_VerificationsCreated] [int] NULL,
	[ANPR_VerificationsApproved] [int] NULL,
	[eCam_VerificationsApproved] [int] NULL,
	[ANPR_RecordsWaitingToBeSentToStella] [int] NULL,
	[ANPR_SentToStella] [int] NULL,
	[eCam_RecordsWaitingToBeSentToStella] [int] NULL,
	[eCam_SentToStella] [int] NULL,
	[ANPR_PCNsCreatedInStella] [int] NULL,
	[eCam_PCNsCreatedInStella] [int] NULL,
	[ANPR_eCam_DVLARequestsSent] [int] NULL,
	[ANPR_eCam_DVLARequestsSuccessfullyReceived] [int] NULL,
	[ANPR_IssuedPCNs] [int] NULL,
	[eCam_IssuedPCNs] [int] NULL,
	[eCam_DVLARequestsSent] [int] NULL,
	[eCam_DVLARequestsSuccessfullyReceived] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MetricID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UKPC Payments Received for DCB Legal]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UKPC Payments Received for DCB Legal](
	[DCBL_Ref] [nvarchar](max) NOT NULL,
	[UKPC_PCN_Ref] [nvarchar](max) NOT NULL,
	[Total_Payments] [decimal](18, 10) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_Cancellation]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_Cancellation](
	[CancellationID] [int] NULL,
	[CancellationReason] [nvarchar](100) NULL,
	[IsDeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_Contravention]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_Contravention](
	[ContraventionID] [int] NULL,
	[ContraventionType] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_Date]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_Date](
	[Date] [date] NULL,
	[Year] [int] NULL,
	[Quarter] [int] NULL,
	[Month] [int] NULL,
	[MonthName] [nvarchar](20) NULL,
	[Day] [int] NULL,
	[DayOfWeek] [int] NULL,
	[DayName] [nvarchar](20) NULL,
	[IsWeekend] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_Metric]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_Metric](
	[MetricID] [int] NOT NULL,
	[MetricName] [varchar](100) NULL,
	[MetricType] [varchar](50) NULL,
	[DateType] [varchar](50) NULL,
	[MetricDescription] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[MetricID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_Site]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_Site](
	[SiteID] [int] NULL,
	[SiteName] [nvarchar](200) NULL,
	[ZoneName] [nvarchar](200) NULL,
	[CompanyName] [nvarchar](200) NULL,
	[PortfolioName] [nvarchar](200) NULL,
	[RegionName] [nvarchar](200) NULL,
	[SubRegionName] [nvarchar](200) NULL,
	[ZoneType] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_DIM_User]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_DIM_User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](101) NOT NULL,
	[UserLoginName] [nvarchar](50) NOT NULL,
	[UserTitle] [nvarchar](100) NULL,
	[UserEmail] [nvarchar](100) NULL,
	[UserRoles] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[ANPRTechOps_FACT]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[ANPRTechOps_FACT](
	[Date] [date] NOT NULL,
	[SiteID] [int] NULL,
	[ContraventionID] [int] NULL,
	[UserID] [int] NULL,
	[CancellationID] [int] NULL,
	[Step] [int] NULL,
	[MetricID] [int] NOT NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[Dim_Date]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[Dim_Date](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TheDate] [date] NULL,
	[TheDay] [int] NULL,
	[TheDayName] [nvarchar](10) NULL,
	[TheWeek] [int] NULL,
	[TheISOWeek] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[TheMonthName] [nvarchar](10) NULL,
	[TheQuarter] [int] NULL,
	[TheFiscalQuarter] [int] NULL,
	[TheYear] [int] NULL,
	[TheFirstOfMonth] [date] NULL,
	[TheLastOfYear] [date] NULL,
	[TheDayOfYear] [int] NULL,
	[TheStartOfWeek] [date] NULL,
	[TheEndOfWeek] [date] NULL,
	[TheWorkingWeek] [nvarchar](30) NULL,
	[TheWeekNumber] [int] NULL,
	[TheMonthAndYear] [nvarchar](50) NULL,
	[TheMonthIndex] [int] NULL,
	[TheWeekIndex] [int] NULL,
	[TheFiscalQuarterName] [nvarchar](50) NULL,
	[TheFiscalQuarterYearAndName] [nvarchar](50) NULL,
	[TheDayAndSuffix] [nvarchar](10) NULL,
	[TheSeason] [nvarchar](50) NULL,
	[TheSeasonIndex] [nvarchar](50) NULL,
	[TheSeasonYear] [int] NULL,
	[IsBankHoliday] [int] NULL,
	[IsWeekend] [int] NULL,
	[IsFollowingWorkingDay] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[Dim_Sites]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[Dim_Sites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneID] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[CompanyID] [int] NULL,
	[CompanyName] [nvarchar](200) NULL,
	[PortfolioID] [int] NULL,
	[PortfolioName] [nvarchar](200) NULL,
	[HasPortfolio] [nvarchar](10) NULL,
	[RegionName] [nvarchar](200) NULL,
	[SubRegionName] [nvarchar](200) NULL,
	[LocationStatus] [nvarchar](20) NULL,
	[ANPR] [bit] NULL,
	[PARKING OPS] [bit] NULL,
	[STS] [bit] NULL,
	[ITICKET] [bit] NULL,
	[ECAM] [bit] NULL,
	[CONTRAVENTION MANAGEMENT] [bit] NULL,
	[OTHER] [bit] NULL,
	[IPARK] [bit] NULL,
	[ITICKETLITE] [bit] NULL,
	[STSNEW] [bit] NULL,
	[KAM] [nvarchar](50) NULL,
	[System] [nvarchar](20) NULL,
	[Sector] [nvarchar](50) NULL,
	[ActiveDate] [datetime] NULL,
	[DeactiveDate] [datetime] NULL,
	[Longitude] [decimal](11, 8) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Postcode] [nvarchar](20) NULL,
	[TotalBays] [int] NULL,
	[DisabledBays] [int] NULL,
	[ParentToddlerBays] [int] NULL,
	[ElectricVehicleBays] [int] NULL,
	[Jurisdiction] [nvarchar](50) NULL,
	[TechOpsLocationID] [int] NULL,
	[ZoneType] [nvarchar](100) NULL,
	[AccountManager] [nvarchar](100) NULL,
	[HasHadANPR] [int] NULL,
	[SectorId] [int] NULL,
	[JurisdictionId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[McDonalds_Cancellations]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[McDonalds_Cancellations](
	[SiteID] [bigint] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Date] [date] NULL,
	[Cancelled] [int] NOT NULL,
	[ContraventionID] [int] NULL,
	[System] [varchar](8) NOT NULL,
	[ONiHubDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[McDonalds_Dim_Cancellation]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[McDonalds_Dim_Cancellation](
	[ID] [int] NULL,
	[CancellationGroup] [nvarchar](255) NULL,
	[CancellationReason] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [development].[McDonalds_Dim_Contravention]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[McDonalds_Dim_Contravention](
	[ID] [int] NULL,
	[ExtranetID] [int] NULL,
	[Summary] [nvarchar](255) NULL,
	[Detail] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [development].[tmp_InitialNotice]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[tmp_InitialNotice](
	[ContraventionID] [bigint] NULL,
	[AccountID] [int] NOT NULL,
	[NTKDateTime] [datetime2](7) NULL,
	[LetterType] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[tmp_PCN_Action]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[tmp_PCN_Action](
	[ID] [int] NOT NULL,
	[ZoneExternalReference] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[LocationName] [nvarchar](100) NOT NULL,
	[ServiceType] [nvarchar](50) NOT NULL,
	[ContraventionStatus] [nvarchar](50) NULL,
	[ContraventionReason] [nvarchar](255) NULL,
	[VRN] [nvarchar](50) NULL,
	[ContraventionEventDateTime] [datetime] NULL,
	[KeeperLookupDate] [datetime2](7) NULL,
	[IssueInitialNoticeDate] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [development].[tmp_PermitAdded]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [development].[tmp_PermitAdded](
	[ContraventionNumber] [bigint] NOT NULL,
	[ContraventionID] [bigint] NULL,
	[ZoneExternalReference] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[ContraventionDateTime] [datetime2](7) NOT NULL,
	[FirstIssuedDate] [date] NULL,
	[ServiceType] [nvarchar](50) NOT NULL,
	[Warden] [nvarchar](50) NULL,
	[StellaOrExtranet] [int] NULL,
	[WardenID] [int] NULL,
	[ContraventionStatus] [nvarchar](50) NULL,
	[ContraventionReason] [nvarchar](255) NULL,
	[LowerAmount] [decimal](10, 2) NULL,
	[UpperAmount] [decimal](10, 2) NULL,
	[IsForeignPlate] [bit] NULL,
	[VRN] [nvarchar](50) NULL,
	[Service_type_prefix] [int] NULL,
	[WardenComments] [nvarchar](max) NULL,
	[ContraventionCreatedDate] [datetime] NULL,
	[ContraventionEventDateTime] [datetime] NULL,
	[LocationName] [nvarchar](100) NULL,
	[WhiteListId] [int] NULL,
	[From] [datetime2](7) NOT NULL,
	[To] [datetime2](7) NOT NULL,
	[PermitAddedDate] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [eCam].[Cameras]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eCam].[Cameras](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CameraID] [int] NULL,
	[CameraName] [nvarchar](255) NULL,
	[CameraCreatedDate] [datetime] NULL,
	[CameraDeletedDate] [datetime] NULL,
	[CameraIsDeleted] [int] NULL,
	[DeployedDate] [date] NULL,
	[CameraVendor] [nvarchar](100) NULL,
	[ZoneName] [nvarchar](255) NULL,
	[ZoneExternalReference] [int] NULL,
	[CameraStatus] [nvarchar](10) NULL,
	[LastWifiStatus] [nvarchar](20) NULL,
	[CameraLastUpdatedDate] [datetime] NULL,
	[CameraCreatedBy] [nvarchar](255) NULL,
	[CameraIP] [nvarchar](50) NULL,
	[CameraUserName] [nvarchar](50) NULL,
	[CameraPassword] [nvarchar](100) NULL,
	[CameraLensCapacity] [nvarchar](50) NULL,
	[CameraServiceType] [nvarchar](20) NULL,
	[ANPRTechOpsCameraID] [int] NULL,
	[CameraLastContactDate] [datetime] NULL,
	[ScreenWidth] [int] NULL,
	[ScreenHeight] [int] NULL,
	[LastBatteryStatus] [int] NULL,
 CONSTRAINT [PK__Cameras__3214EC273D472C44] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eCam].[Contraventions_Issued]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eCam].[Contraventions_Issued](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ContraventionStatus] [nvarchar](30) NULL,
	[ContraventionDate] [datetime] NULL,
	[FirstIssuedDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[CameraName] [nvarchar](255) NULL,
	[CameraID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[Cancelled]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[Cancelled](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPI] [int] NULL,
	[Date] [date] NULL,
	[Amount] [int] NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[CRM_Appointments]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[CRM_Appointments](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AppointmentCreatedDate] [date] NULL,
	[CreatedBy] [nvarchar](200) NULL,
	[Total] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[CRM_ContractsReceived]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[CRM_ContractsReceived](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ContractReceivedDate] [date] NULL,
	[OwnerName] [nvarchar](250) NULL,
	[ANPR] [nvarchar](10) NULL,
	[PPS] [nvarchar](10) NULL,
	[eCAM] [nvarchar](10) NULL,
	[Total] [int] NULL,
	[dDate] [date] NULL,
 CONSTRAINT [PK__CRM_Cont__3214EC27ADB04BEE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[HR_Absence]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[HR_Absence](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPI] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Total] [decimal](5, 2) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Deleted] [datetime] NULL,
 CONSTRAINT [PK__HR_Absen__3214EC279BAC0A17] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[HR_Attrition]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[HR_Attrition](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPI] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[AttritionPercentage] [decimal](5, 2) NOT NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
 CONSTRAINT [PK__HR_Attri__3214EC27DA1FE9CC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[Issued]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[Issued](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPI] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Amount] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Deleted] [datetime] NULL,
 CONSTRAINT [PK_Issued] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[KPI]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[KPI](
	[KPIID] [int] IDENTITY(1,1) NOT NULL,
	[Benchmark] [decimal](18, 2) NULL,
	[Description] [nvarchar](255) NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
	[Department] [int] NULL,
	[Owner] [int] NULL,
 CONSTRAINT [PK__Benchmar__3214EC272BDB3720] PRIMARY KEY CLUSTERED 
(
	[KPIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[KPIBenchmarks]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[KPIBenchmarks](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPIID] [int] NULL,
	[dDate] [date] NULL,
	[Description] [nvarchar](255) NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
	[Benchmark] [decimal](16, 8) NULL,
 CONSTRAINT [PK__KPIBench__3214EC27C4717813] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[POShiftTotals]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[POShiftTotals](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[WardenID] [nvarchar](100) NULL,
	[FullName] [nvarchar](100) NULL,
	[Region] [nvarchar](100) NULL,
	[ScheduledShifts] [int] NULL,
	[Holidays] [int] NULL,
	[ExpectedShifts] [int] NULL,
	[ShiftsWorked] [int] NULL,
 CONSTRAINT [PK__POShiftT__3214EC27790E8259] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [KPI].[Revenue]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [KPI].[Revenue](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[KPI] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Deleted] [datetime] NULL,
 CONSTRAINT [PK_Revenue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[CaseContraventions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[CaseContraventions](
	[CaseContraventionID] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[CaseStatus] [nvarchar](50) NULL,
	[StatusID] [int] NULL,
	[ExcludeReason] [nvarchar](200) NULL,
	[ExcludeNote] [nvarchar](255) NULL,
	[ActionDate] [datetime] NULL,
	[ActionedBy] [nvarchar](100) NULL,
	[ActionedByID] [int] NULL,
	[Plate] [nvarchar](20) NULL,
	[VerifierUserID] [int] NULL,
 CONSTRAINT [PK__CaseCont__93B72C9368AD30E3] PRIMARY KEY CLUSTERED 
(
	[CaseContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[ClaimContraventionLinks]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[ClaimContraventionLinks](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClaimId] [int] NULL,
	[ContraventionId] [int] NULL,
	[Status] [int] NULL,
	[Created] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[Claims]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[Claims](
	[LitigationClaimID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClaimID] [int] NULL,
	[ClaimReference] [nvarchar](20) NULL,
	[ClaimStatus] [nvarchar](20) NULL,
	[ClaimStatusID] [int] NULL,
	[HandlerName] [nvarchar](150) NULL,
	[HandlerID] [int] NULL,
	[VerifierName] [nvarchar](150) NULL,
	[VerifierID] [int] NULL,
	[EntityType] [nvarchar](50) NULL,
	[WorkflowName] [nvarchar](200) NULL,
	[IsFleetHire] [int] NULL,
	[RelationshipType] [nvarchar](50) NULL,
	[DaysInProgress] [int] NULL,
	[DaysOnHold] [int] NULL,
	[LOCCreatedDate] [date] NULL,
	[LatestPaymentDate] [date] NULL,
	[PaidDate] [date] NULL,
	[MonthsToPaid] [int] NULL,
	[StatusLinkDate] [date] NULL,
	[StatusDetails] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[LitigationClaimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[ClaimStatus]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[ClaimStatus](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[SortOrder] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[ClaimTransactions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[ClaimTransactions](
	[ClaimTransactionID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClaimID] [int] NULL,
	[ClaimNumber] [nvarchar](50) NULL,
	[Amount] [decimal](10, 2) NULL,
	[TransactionTypeID] [int] NULL,
	[PaymentDate] [datetime] NULL,
	[ClaimStatus] [nvarchar](50) NULL,
	[StatusDetails] [nvarchar](50) NULL,
	[TransactionType] [nvarchar](50) NULL,
	[PaidInNMonths] [int] NULL,
 CONSTRAINT [PK__ClaimTra__2F9489E2EE166387] PRIMARY KEY CLUSTERED 
(
	[ClaimTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Litigation].[Payments]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Litigation].[Payments](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[ClaimID] [int] NULL,
	[ClaimValue] [decimal](18, 2) NULL,
	[ClaimTotalPaid] [decimal](18, 2) NULL,
	[ContraventionTotalPaid] [decimal](18, 2) NULL,
	[LatestPaymentDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Monday].[ANPR_Sites]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Monday].[ANPR_Sites](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[SiteName] [nvarchar](200) NULL,
	[SiteID] [int] NULL,
 CONSTRAINT [PK_Stella_Appeals_AppealsID] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Monday].[InstallationTracker]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Monday].[InstallationTracker](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Item] [nvarchar](max) NOT NULL,
	[ContractSignedDate] [date] NULL,
	[PIDSignedDate] [date] NULL,
	[SLAInstallDate] [date] NULL,
	[ActualGoLiveDate] [date] NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Monday_InstallationTracker_ItemID] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Monday].[Schedule_JobEntry]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Monday].[Schedule_JobEntry](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Job] [nvarchar](max) NOT NULL,
	[JobDescription] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[AllocatedDate] [date] NULL,
	[FaultStart] [date] NULL,
	[SiteID] [int] NULL,
	[DateCompleted] [date] NULL,
	[Status] [nvarchar](20) NULL,
 CONSTRAINT [PK_Monday_Schedule_ItemID] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [NPED].[UnPaidContraventions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NPED].[UnPaidContraventions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PCN_REF_NO] [bigint] NULL,
	[ISSUED_DATE] [date] NULL,
	[VRM] [nvarchar](200) NULL,
	[POSTCODE_PREFIX] [nvarchar](10) NULL,
	[REASON] [nvarchar](200) NULL,
	[NPED_STATUS] [nvarchar](100) NULL,
	[PCN_STATUS] [nvarchar](20) NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ANPR_MatchRate]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ANPR_MatchRate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MovementInDate] [date] NULL,
	[MovementInMonthYear] [nvarchar](7) NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneName] [nvarchar](255) NULL,
	[TotalMovements] [int] NULL,
	[TotalMatches] [int] NULL,
	[MatchRate] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ANPR_RepeatVisits]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ANPR_RepeatVisits](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TechOpsLocationID] [int] NULL,
	[ZoneId] [int] NULL,
	[TotalRecords] [int] NULL,
	[TotalRepeatsLastYear] [int] NULL,
	[TotalRepeatsThisYear] [int] NULL,
	[LastRun] [datetime] NULL,
	[OutReadMonth] [date] NULL,
	[IsARepeat] [int] NULL,
	[VisitPeriod] [nvarchar](20) NULL,
	[TotalLastYear] [int] NULL,
	[TotalThisYear] [int] NULL,
 CONSTRAINT [PK__ANPR_Rep__3214EC272CE6DA19] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Client_Reporting]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Client_Reporting](
	[ReadDate] [datetime] NULL,
	[ReadYear] [int] NULL,
	[Weekday] [nvarchar](10) NULL,
	[QtyIn] [bigint] NULL,
	[TotalStaffVehicles] [bigint] NULL,
	[EVVehicles] [bigint] NULL,
	[DIESELVehicles] [bigint] NULL,
	[PETROLVehicles] [bigint] NULL,
	[OTHERVehicles] [bigint] NULL,
	[0-60Minutes] [bigint] NULL,
	[60-120Minutes] [bigint] NULL,
	[120-180Minutes] [bigint] NULL,
	[180-240Minutes] [bigint] NULL,
	[240-300Minutes] [bigint] NULL,
	[300-360Minutes] [bigint] NULL,
	[360+Minutes] [bigint] NULL,
	[AverageStay] [time](7) NULL,
	[Occupancy_01] [bigint] NULL,
	[Occupancy_02] [bigint] NULL,
	[Occupancy_03] [bigint] NULL,
	[Occupancy_04] [bigint] NULL,
	[Occupancy_05] [bigint] NULL,
	[Occupancy_06] [bigint] NULL,
	[Occupancy_07] [bigint] NULL,
	[Occupancy_08] [bigint] NULL,
	[Occupancy_09] [bigint] NULL,
	[Occupancy_10] [bigint] NULL,
	[Occupancy_11] [bigint] NULL,
	[Occupancy_12] [bigint] NULL,
	[Occupancy_13] [bigint] NULL,
	[Occupancy_14] [bigint] NULL,
	[Occupancy_15] [bigint] NULL,
	[Occupancy_16] [bigint] NULL,
	[Occupancy_17] [bigint] NULL,
	[Occupancy_18] [bigint] NULL,
	[Occupancy_19] [bigint] NULL,
	[Occupancy_20] [bigint] NULL,
	[Occupancy_21] [bigint] NULL,
	[Occupancy_22] [bigint] NULL,
	[Occupancy_23] [bigint] NULL,
	[Occupancy_24] [bigint] NULL,
	[Visits_1] [bigint] NULL,
	[Visits_2] [bigint] NULL,
	[Visits_3] [bigint] NULL,
	[Visits_4] [bigint] NULL,
	[Visits_5] [bigint] NULL,
	[Visits_6-9] [bigint] NULL,
	[Visits_10+] [bigint] NULL,
	[AverageStaySeconds] [bigint] NULL,
	[StaffAverageDuration] [bigint] NULL,
	[Staff 0-60Minutes] [bigint] NULL,
	[Staff 60-120Minutes] [bigint] NULL,
	[Staff 120-180Minutes] [bigint] NULL,
	[Staff 180-240Minutes] [bigint] NULL,
	[Staff 240-300Minutes] [bigint] NULL,
	[Staff 300-360Minutes] [bigint] NULL,
	[Staff 360+Minutes] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ContraventionsPerDay_Stella]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ContraventionsPerDay_Stella](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionDate] [date] NULL,
	[TotalContraventions] [int] NULL,
	[ZoneExternalReference] [int] NULL,
	[LocationID] [int] NULL,
	[WasIssuedToDriver] [int] NULL,
	[WasNotIssuedToDriver] [int] NULL,
	[ServiceType] [nvarchar](25) NULL,
	[Warden] [nvarchar](75) NULL,
 CONSTRAINT [PK__Contrave__3214EC27DA7BAB24] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DateTable]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DateTable](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TheDate] [date] NULL,
	[TheDay] [int] NULL,
	[TheDayName] [nvarchar](10) NULL,
	[TheWeek] [int] NULL,
	[TheISOWeek] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[TheMonthName] [nvarchar](10) NULL,
	[TheQuarter] [int] NULL,
	[TheFiscalQuarter] [int] NULL,
	[TheYear] [int] NULL,
	[TheFirstOfMonth] [date] NULL,
	[TheLastOfYear] [date] NULL,
	[TheDayOfYear] [int] NULL,
	[TheStartOfWeek] [date] NULL,
	[TheEndOfWeek] [date] NULL,
	[TheWorkingWeek] [nvarchar](30) NULL,
	[TheWeekNumber] [int] NULL,
	[TheMonthAndYear] [nvarchar](50) NULL,
	[TheMonthIndex] [int] NULL,
	[TheWeekIndex] [int] NULL,
	[TheFiscalQuarterName] [nvarchar](50) NULL,
	[TheFiscalQuarterYearAndName] [nvarchar](50) NULL,
	[TheDayAndSuffix] [nvarchar](10) NULL,
	[TheSeason] [nvarchar](50) NULL,
	[TheSeasonIndex] [nvarchar](50) NULL,
	[TheSeasonYear] [int] NULL,
 CONSTRAINT [PK__DateTabl__3214EC2779701C6F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DateTableFuture]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DateTableFuture](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TheDate] [date] NULL,
	[TheDay] [int] NULL,
	[TheDayName] [nvarchar](10) NULL,
	[TheWeek] [int] NULL,
	[TheISOWeek] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[TheMonthName] [nvarchar](10) NULL,
	[TheQuarter] [int] NULL,
	[TheFiscalQuarter] [int] NULL,
	[TheYear] [int] NULL,
	[TheFirstOfMonth] [date] NULL,
	[TheLastOfYear] [date] NULL,
	[TheDayOfYear] [int] NULL,
	[TheStartOfWeek] [date] NULL,
	[TheEndOfWeek] [date] NULL,
	[TheWorkingWeek] [nvarchar](30) NULL,
	[TheWeekNumber] [int] NULL,
	[TheMonthAndYear] [nvarchar](50) NULL,
	[TheMonthIndex] [int] NULL,
	[TheWeekIndex] [int] NULL,
	[TheFiscalQuarterName] [nvarchar](50) NULL,
	[TheFiscalQuarterYearAndName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DetailedVerifications]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DetailedVerifications](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[OverstayId] [int] NULL,
	[User] [nvarchar](100) NULL,
	[ZoneId] [int] NULL,
	[ZoneName] [nvarchar](100) NULL,
	[LocationName] [nvarchar](100) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[Step] [int] NULL,
	[Status] [nvarchar](100) NULL,
	[Status+Step] [nvarchar](100) NULL,
	[CancellationReason] [nvarchar](100) NULL,
 CONSTRAINT [PK__Detailed__3214EC27003DA844] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[DetailedVerifications_StellaOnly]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[DetailedVerifications_StellaOnly](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[OverstayId] [int] NULL,
	[User] [nvarchar](100) NULL,
	[ZoneId] [int] NULL,
	[ZoneName] [nvarchar](100) NULL,
	[LocationName] [nvarchar](100) NULL,
	[ServiceType] [nvarchar](100) NULL,
	[Step] [int] NULL,
	[Status] [nvarchar](100) NULL,
	[Status+Step] [nvarchar](100) NULL,
	[CancellationReason] [nvarchar](100) NULL,
 CONSTRAINT [PK__Detailed__V] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ExecutiveReport]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ExecutiveReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[Jurisdiction] [int] NULL,
	[Sector] [int] NULL,
	[Prefix] [int] NULL,
	[PaidDirect] [int] NULL,
	[IsStella] [int] NULL,
	[TotalIssued] [int] NULL,
	[RevCash] [decimal](10, 2) NULL,
	[PaidDirectCash] [decimal](10, 2) NULL,
	[SplitCash] [decimal](10, 2) NULL,
	[1MonthCash] [decimal](10, 2) NULL,
	[2MonthCash] [decimal](10, 2) NULL,
	[3MonthCash] [decimal](10, 2) NULL,
	[4MonthCash] [decimal](10, 2) NULL,
	[5MonthCash] [decimal](10, 2) NULL,
	[6MonthCash] [decimal](10, 2) NULL,
	[7MonthCash] [decimal](10, 2) NULL,
	[8MonthCash] [decimal](10, 2) NULL,
	[9MonthCash] [decimal](10, 2) NULL,
	[10MonthCash] [decimal](10, 2) NULL,
	[11MonthCash] [decimal](10, 2) NULL,
	[12+MonthCash] [decimal](10, 2) NULL,
	[1MonthPaid] [int] NULL,
	[2MonthPaid] [int] NULL,
	[3MonthPaid] [int] NULL,
	[4MonthPaid] [int] NULL,
	[5MonthPaid] [int] NULL,
	[6MonthPaid] [int] NULL,
	[7MonthPaid] [int] NULL,
	[8MonthPaid] [int] NULL,
	[9MonthPaid] [int] NULL,
	[10MonthPaid] [int] NULL,
	[11MonthPaid] [int] NULL,
	[12+MonthPaid] [int] NULL,
	[CashFromIssued] [decimal](10, 2) NULL,
	[AccumilativeMonth1] [int] NULL,
	[AccumilativeMonth2] [int] NULL,
	[AccumilativeMonth3] [int] NULL,
	[AccumilativeMonth4] [int] NULL,
	[AccumilativeMonth5] [int] NULL,
	[AccumilativeMonth6] [int] NULL,
	[AccumilativeMonth7] [int] NULL,
	[AccumilativeMonth8] [int] NULL,
	[AccumilativeMonth9] [int] NULL,
	[AccumilativeMonth10] [int] NULL,
	[AccumilativeMonth11] [int] NULL,
	[AccumilativeMonth12] [int] NULL,
	[TotalPaid] [int] NULL,
 CONSTRAINT [PK__Executiv__3214EC271DAECB6B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[GOGWLateAppeal]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[GOGWLateAppeal](
	[AccountId] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[Reference] [nvarchar](20) NOT NULL,
	[Status] [int] NOT NULL,
	[AppealId] [int] NOT NULL,
	[AppealStatus] [int] NOT NULL,
	[GOGWDate] [date] NULL,
	[NextAppealId] [int] NULL,
	[PaidAmount] [numeric](38, 2) NULL,
	[PaidDate] [date] NULL,
	[method] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[IssuedTicketsWithMultipleOffenders]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[IssuedTicketsWithMultipleOffenders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneId] [int] NULL,
	[ZoneExternalReference] [int] NULL,
	[TotalIssued] [int] NULL,
	[LastYearMultipleOffenders] [int] NULL,
	[ThisYearMultipleOffenders] [int] NULL,
	[LastRun] [datetime] NULL,
	[ThisYearIssued] [int] NULL,
	[LastYearIssued] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[POSiteVisits]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[POSiteVisits](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WardenID] [int] NULL,
	[FullName] [nvarchar](100) NULL,
	[JobTitle] [nvarchar](100) NULL,
	[DateTime] [datetime] NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[LocationName] [nvarchar](100) NULL,
	[LocationId] [int] NULL,
	[ZoneName] [nvarchar](100) NULL,
	[ZoneId] [int] NULL,
	[ZoneExternalReference] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[PPSBonusPayments]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[PPSBonusPayments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WeekMarker] [date] NULL,
	[WeekCommence] [date] NULL,
	[WardenName] [nvarchar](255) NULL,
	[PayrollId] [nvarchar](50) NULL,
	[HoursWorked] [decimal](10, 2) NULL,
	[Expectation] [decimal](10, 2) NULL,
	[TotalIssued] [int] NULL,
	[BonusEligiblePCNS] [decimal](10, 2) NULL,
	[BonusPayable] [decimal](18, 2) NULL,
	[PerformanceID] [decimal](10, 2) NULL,
	[Region] [nvarchar](200) NULL,
 CONSTRAINT [PK__PPSBonus__3214EC270AA636B7] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[PRPReport]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[PRPReport](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[WeekCommence] [date] NULL,
	[WardenID] [nvarchar](100) NULL,
	[FullName] [nvarchar](100) NULL,
	[Region] [nvarchar](100) NULL,
	[ContractedHours] [decimal](10, 2) NULL,
	[HoursWorked] [decimal](10, 2) NULL,
	[HoursBreak] [decimal](10, 2) NULL,
	[HoursHoliday] [decimal](10, 2) NULL,
	[HoursToil] [decimal](10, 2) NULL,
	[HoursSick] [decimal](10, 2) NULL,
	[HoursAbsent] [decimal](10, 2) NULL,
	[HoursUn-Absent] [decimal](10, 2) NULL,
	[PercentageHoursWorked] [decimal](10, 3) NULL,
	[PCNsIssued] [int] NULL,
	[PCNsCancelledAsOperativeError] [int] NULL,
	[PCNsIssuedPerHour] [decimal](10, 3) NULL,
	[PCNsIssuedCorrectlyPerHour] [decimal](10, 3) NULL,
	[PerformanceID] [int] NULL,
	[JobTitle] [nvarchar](100) NULL,
 CONSTRAINT [PK__PRPRepor__3214EC2735FA3375] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[ServiceTypes]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[ServiceTypes](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServiceType] [nvarchar](25) NULL,
	[ExtranetStellaBoth] [int] NULL,
	[Prefix] [int] NULL,
	[ContraventionTypeID] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK__ServiceT__3214EC27E2069EBA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Stella_Accounts]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Stella_Accounts](
	[Id] [int] NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[Updated] [datetime2](7) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
	[Deleted] [datetime2](7) NULL,
	[LastLogin] [datetime2](7) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[IsSendMail] [bit] NOT NULL,
	[EmailCount] [int] NOT NULL,
	[LastEmailSentTime] [datetime2](7) NULL,
	[IAMUserId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Stella_Jurisdictions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Stella_Jurisdictions](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[JurisdictionId] [int] NULL,
	[JurisdictionName] [nvarchar](50) NULL,
 CONSTRAINT [PK__Jurisdiction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Stella_Regions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Stella_Regions](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CountryRegionId] [int] NULL,
	[SubRegionId] [int] NULL,
	[SubRegionName] [nvarchar](200) NULL,
	[RegionName] [nvarchar](200) NULL,
 CONSTRAINT [PK__Regions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Stella_Sectors]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Stella_Sectors](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SectorId] [int] NULL,
	[SectorName] [nvarchar](50) NULL,
 CONSTRAINT [PK__Sector] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Stella_Services_YearOnYear]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Stella_Services_YearOnYear](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneId] [int] NULL,
	[ServiceGroup] [nvarchar](50) NULL,
	[LastYear] [int] NULL,
	[ThisYear] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[StellaExtranet]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[StellaExtranet](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ExtranetOrStella] [int] NULL,
	[Name] [nvarchar](15) NULL,
 CONSTRAINT [PK__StellaEx__3214EC27731EB904] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[StellaSnapshot]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[StellaSnapshot](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [int] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ServiceTypePrefix] [int] NULL,
	[FirstIssuedDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[SnapshotStatus] [nvarchar](300) NULL,
	[DCCompany] [nvarchar](300) NULL,
	[PlacementLevel] [nvarchar](40) NULL,
	[OutstandingBalance] [decimal](18, 2) NULL,
	[IsForeignPlate] [int] NULL,
	[IsPermHold] [int] NULL,
 CONSTRAINT [PK__StellaSn__57C1D04DBB104AD4] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[StellaSnapshot_History]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[StellaSnapshot_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SnapshotDate] [date] NOT NULL,
	[ContraventionID] [int] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ServiceTypePrefix] [int] NULL,
	[FirstIssuedDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[SnapshotStatus] [nvarchar](300) NULL,
	[DCCompany] [nvarchar](300) NULL,
	[PlacementLevel] [nvarchar](40) NULL,
	[OutstandingBalance] [decimal](18, 2) NULL,
	[IsForeignPlate] [int] NULL,
	[IsPermHold] [int] NULL,
 CONSTRAINT [PK__StellaSn__57C1D04DBB104AD4w] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[TimeTable]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[TimeTable](
	[Hour] [int] NULL,
	[Minute] [int] NULL,
	[Second] [int] NULL,
	[Time] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[UKPCWebsiteStats]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[UKPCWebsiteStats](
	[DateRun] [date] NULL,
	[TotalFootfall] [bigint] NULL,
	[TotalIssued] [int] NULL,
	[TotalZones] [int] NULL,
	[TotalTimeSpentSeconds] [bigint] NULL,
	[TotalEVVehicles] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Verifications_AllData]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Verifications_AllData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SystemActioned] [nvarchar](30) NULL,
	[VerifiedDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[Verifications_RollingWeeklyAverage]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[Verifications_RollingWeeklyAverage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneName] [nvarchar](255) NULL,
	[WeekStart] [date] NULL,
	[WeeklyTotal] [int] NULL,
	[RollingAverage] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[VerificationStatistics]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[VerificationStatistics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VerifiedDate] [date] NULL,
	[UserName] [nvarchar](100) NULL,
	[ProductType] [nvarchar](100) NULL,
	[CancellationReason] [nvarchar](100) NULL,
	[eCamCreated] [int] NULL,
	[eCamVerifiedStep1] [int] NULL,
	[eCamCancelledStep1] [int] NULL,
	[eCamVerifiedStep2] [int] NULL,
	[eCamCancelledStep2] [int] NULL,
	[StellaCreated] [int] NULL,
	[StellaVerified] [int] NULL,
	[StellaCancelled] [int] NULL,
	[ANPRTechOpsCreated] [int] NULL,
	[ANPRTechOpsVerifiedStep1] [int] NULL,
	[ANPRTechOpsCancelledStep1] [int] NULL,
	[ANPRTechOpsNewPlateStep1] [int] NULL,
	[ANPRTechOpsVerifiedStep2] [int] NULL,
	[ANPRTechOpsCancelledStep2] [int] NULL,
	[ANPRTechOpsNewPlateStep2] [int] NULL,
 CONSTRAINT [PK_VerificationStatistics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[WardenAlerts]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[WardenAlerts](
	[AlertID] [int] IDENTITY(1,1) NOT NULL,
	[AlertType] [nvarchar](255) NULL,
	[WardenID] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
	[ClusterId] [int] NULL,
	[Location/Cluster] [nvarchar](255) NULL,
	[RotaFrom] [datetime] NULL,
	[RotaTo] [datetime] NULL,
	[LoggedAtTime] [datetime] NULL,
	[StandardLogTime] [datetime] NULL,
	[WhyRemoved] [nvarchar](255) NULL,
	[WardenExternalID] [nvarchar](50) NULL,
	[WardenName] [nvarchar](255) NULL,
 CONSTRAINT [PK__WardenAl__EBB16AED3ACECA16] PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[WardenHourlyIssued]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[WardenHourlyIssued](
	[WardenId] [int] NULL,
	[ZoneID] [int] NULL,
	[LocationID] [int] NULL,
	[DateIssued] [date] NULL,
	[TimeIssued] [time](7) NULL,
	[DateIssuedFullDate] [datetime] NULL,
	[Type] [int] NULL,
	[ContraventionID] [bigint] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ServiceType] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[WardenLocations]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[WardenLocations](
	[LocationID] [bigint] NOT NULL,
	[LocationName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reporting].[WardenStats]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reporting].[WardenStats](
	[WardenID] [int] NULL,
	[Date] [date] NULL,
	[FullDateTime] [datetime] NULL,
	[LocationID] [int] NULL,
	[ZoneID] [int] NULL,
	[Type] [int] NULL,
	[Detail] [nvarchar](max) NULL,
	[IsStartShift] [int] NULL,
	[IsEndShift] [int] NULL,
	[IsCheckIn] [int] NULL,
	[IsCheckOut] [int] NULL,
	[IsStartBreak] [int] NULL,
	[IsEndBreak] [int] NULL,
	[IsAddFirstSeen] [int] NULL,
	[IsAddGracePeriod] [int] NULL,
	[IsTrackGPS] [int] NULL,
	[IsIssuePCN] [int] NULL,
	[IsAbort] [int] NULL,
	[DistanceToSite] [bigint] NULL,
	[TravelTimeToSite] [bigint] NULL,
	[AbortReason] [nvarchar](max) NULL,
	[WardenExternalID] [nvarchar](50) NULL,
	[ContraventionNumber] [nvarchar](25) NULL,
	[ServiceType] [nvarchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Matches]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Matches](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[InDate] [date] NULL,
	[SumStayDuration] [bigint] NULL,
	[VisitCount] [int] NULL,
	[AveLengthOfStay] [int] NULL,
	[EVCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Movements]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Movements](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[ReadDate] [date] NULL,
	[QtyTotal] [int] NULL,
	[QtyIn] [int] NULL,
	[QtyOut] [int] NULL,
	[QtyUnknown] [int] NULL,
	[QtyInMatched] [int] NULL,
	[QtyOutMatched] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_OperationalPeriodDates]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_OperationalPeriodDates](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[SiteID] [int] NULL,
	[EnforcedTimeLimitAveSeconds] [int] NULL,
	[SignageTimeLimitAveSeconds] [int] NULL,
	[GracePeriodAveSeconds] [int] NULL,
 CONSTRAINT [PK__ANPRTechOps_OperationalPeriodDates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Overstays]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Overstays](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[InDate] [date] NULL,
	[TotalOverstays] [int] NULL,
	[Contravention] [nvarchar](75) NULL,
	[Transferred] [int] NULL,
	[EnforcedTimeLimitAveSeconds] [int] NULL,
	[SignageTimeLimitAveSeconds] [int] NULL,
	[GracePeriodAveSeconds] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Verifications]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Verifications](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[InDate] [date] NULL,
	[SiteID] [int] NULL,
	[Username] [nvarchar](150) NULL,
	[Step1_total] [int] NULL,
	[Step1_verified] [int] NULL,
	[Step1_cancelled] [int] NULL,
	[Step1_newplate] [int] NULL,
	[Step2_total] [int] NULL,
	[Step2_verified] [int] NULL,
	[Step2_cancelled] [int] NULL,
	[Step2_newplate] [int] NULL,
 CONSTRAINT [PK__ANPRTech__3214EC27067420BF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Verifications_Actions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Verifications_Actions](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [date] NULL,
	[SiteID] [int] NULL,
	[Username] [nvarchar](150) NULL,
	[Total] [int] NULL,
	[Verified] [int] NULL,
	[Cancelled] [int] NULL,
	[Newplate] [int] NULL,
	[Step] [int] NULL,
 CONSTRAINT [PK_ANPRVerificationsActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Verifications_Cancellations]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Verifications_Cancellations](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [date] NOT NULL,
	[SiteID] [int] NULL,
	[Username] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[TotalCancellations] [int] NULL,
	[CancellationReason] [nvarchar](50) NULL,
 CONSTRAINT [PK__ANPRTech__3214EC276FFA9C87] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Verifications_Created]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Verifications_Created](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [date] NULL,
	[SiteID] [int] NULL,
	[TotalCreated] [int] NULL,
	[Step] [int] NULL,
 CONSTRAINT [PK_ANPRTechOpsVerificationsCreated] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[ANPRTechOps_Verifications_Steps]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[ANPRTechOps_Verifications_Steps](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Step] [int] NULL,
 CONSTRAINT [PK_ANPRTechOpsVerificationsSteps] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[CommissionStatementReports]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[CommissionStatementReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SelectedExtranetSiteId] [int] NULL,
	[SelectedExtranetSite] [nvarchar](max) NOT NULL,
	[StartAt] [datetime2](7) NOT NULL,
	[EndAt] [datetime2](7) NOT NULL,
	[PercentShare] [float] NULL,
	[PrepareFor] [nvarchar](100) NULL,
	[PrepareBy] [nvarchar](100) NULL,
	[DiffDays] [float] NOT NULL,
	[CostForWardenOnSites] [float] NOT NULL,
	[CostForNIContributor] [float] NOT NULL,
	[TotalCostForWarden] [float] NOT NULL,
	[AmountPDAOnSite] [float] NOT NULL,
	[AmountUniformForEachWarden] [float] NOT NULL,
	[CostForSignage] [float] NOT NULL,
	[TimeAllocationSentByHeadOfficeStaff] [float] NOT NULL,
	[TimeAllocationPercentIncome] [float] NOT NULL,
	[TimeAllocationPercentageAgainstWithTotalSites] [float] NOT NULL,
	[OtherCost] [float] NOT NULL,
	[OtherCostAssociateWithThisSite] [float] NOT NULL,
	[PercentageTax] [float] NULL,
	[PercentageCommission] [float] NULL,
	[PermitCost] [float] NOT NULL,
	[IssuedPCNs] [float] NOT NULL,
	[CancelledPCNs] [float] NOT NULL,
	[Revenue] [nvarchar](max) NOT NULL,
	[CostForDVLA] [nvarchar](max) NOT NULL,
	[OperatingCosts] [nvarchar](max) NOT NULL,
	[OtherOperatingCosts] [nvarchar](max) NOT NULL,
	[IndirectCosts] [nvarchar](max) NOT NULL,
	[OperatingProfit] [float] NOT NULL,
	[Summaries] [nvarchar](max) NOT NULL,
	[ExtranetSiteStatistic] [nvarchar](max) NOT NULL,
	[StellaSiteStatistic] [nvarchar](max) NOT NULL,
	[StellaPayment] [nvarchar](max) NOT NULL,
	[StellaRefund] [nvarchar](max) NOT NULL,
	[ExtranetPayment] [nvarchar](max) NOT NULL,
	[FixedCostForHeadOfficeRent] [float] NOT NULL,
	[FixedCostForHeadOfficeStaff] [float] NOT NULL,
	[FixedCostForTravelExpenses] [float] NOT NULL,
	[FixedCostForInsurance] [float] NOT NULL,
	[FixedCostForLegalCost] [float] NOT NULL,
	[FixedCostForProfessionalFee] [float] NOT NULL,
	[FixedCostForBankChanges] [float] NOT NULL,
	[DirectCosts] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions](
	[ContraventionNumber] [bigint] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[ZoneExternalReference] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[ContraventionDateTime] [datetime2](7) NOT NULL,
	[FirstIssuedDate] [date] NULL,
	[ServiceType] [nvarchar](50) NOT NULL,
	[Warden] [nvarchar](50) NULL,
	[StellaOrExtranet] [int] NULL,
	[WardenID] [int] NULL,
	[ContraventionStatus] [nvarchar](50) NULL,
	[ContraventionReason] [nvarchar](255) NULL,
	[LowerAmount] [decimal](10, 2) NULL,
	[UpperAmount] [decimal](10, 2) NULL,
	[IsForeignPlate] [bit] NULL,
	[VRN] [nvarchar](50) NULL,
	[Service_type_prefix] [int] NULL,
	[WardenComments] [nvarchar](max) NULL,
	[ContraventionCreatedDate] [datetime] NULL,
	[ContraventionEventDateTime] [datetime] NULL,
 CONSTRAINT [PK_Contraventions] PRIMARY KEY CLUSTERED 
(
	[ContraventionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_Cancellations_Split]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_Cancellations_Split](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[CancelledDate] [date] NULL,
	[DateIssued] [date] NULL,
	[SiteID] [int] NULL,
	[CancelledReason] [nvarchar](100) NULL,
	[ServiceType] [nvarchar](50) NULL,
	[1stMonthCancelled] [int] NULL,
	[2ndMonthCancelled] [int] NULL,
	[3rdMonthCancelled] [int] NULL,
	[4thMonthCancelled] [int] NULL,
	[5thMonthCancelled] [int] NULL,
	[6thMonthCancelled] [int] NULL,
	[7thMonthCancelled] [int] NULL,
	[8thMonthCancelled] [int] NULL,
	[9thMonthCancelled] [int] NULL,
	[10thMonthCancelled] [int] NULL,
	[11thMonthCancelled] [int] NULL,
	[12thMonthCancelled] [int] NULL,
	[13thMonthPlusCancelled] [int] NULL,
 CONSTRAINT [PK__Contrave__93B72C9354B0533F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_NTKs]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_NTKs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [bigint] NULL,
	[NTKSentDate] [date] NULL,
	[LetterType] [nvarchar](50) NULL,
 CONSTRAINT [PK__Contrave__3214EC2726A58A23] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_OutstandingBalances]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_OutstandingBalances](
	[ContraventionID] [bigint] NOT NULL,
	[OutstandingAmount] [decimal](10, 2) NULL,
	[LastPaymentDate] [date] NULL,
 CONSTRAINT [PK__Contrave__93B72C93FB8CCCDE] PRIMARY KEY CLUSTERED 
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_PaidDirects]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_PaidDirects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionId] [bigint] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ContraventionDate] [datetime] NULL,
	[DebtPlacementDate] [date] NULL,
	[PaymentDate] [date] NULL,
	[APIStatusSentDate] [datetime] NULL,
	[APIInstruction] [nvarchar](50) NULL,
	[DRCompany] [nvarchar](100) NULL,
	[PaidDirectPayment] [decimal](10, 2) NULL,
	[DRPayment] [decimal](10, 2) NULL,
	[PaidVia] [nvarchar](50) NULL,
	[ZoneExternalReference] [int] NULL,
	[ServiceTypePrefix] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_ServiceTypes]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_ServiceTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Service_type] [nvarchar](25) NULL,
	[Service_type_prefix] [int] NULL,
	[Department] [int] NULL,
	[Contravention_type] [int] NULL,
	[Legacy_service_type] [int] NULL,
	[Owner] [int] NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
	[Service_Type_Filter] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_ServiceTypes_ContraventionTypes]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_ServiceTypes_ContraventionTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Contravention_type] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
 CONSTRAINT [PK__ServiceT__57C1D04D85C3210E] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Contraventions_ServiceTypes_Department]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Contraventions_ServiceTypes_Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Department] [nvarchar](50) NULL,
	[Created] [datetime] NULL,
	[Deleted] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[DebtRecovery_All]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[DebtRecovery_All](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DRProfile] [nvarchar](50) NOT NULL,
	[ContraventionID] [int] NOT NULL,
	[ContraventionNumber] [bigint] NOT NULL,
	[ContraventionStatus] [nvarchar](50) NOT NULL,
	[ZoneName] [nvarchar](150) NOT NULL,
	[ZoneSiteID] [int] NOT NULL,
	[LocationName] [nvarchar](250) NOT NULL,
	[DRCompany] [nvarchar](20) NOT NULL,
	[DRStatus] [nvarchar](100) NOT NULL,
	[PlacementLevel] [nvarchar](100) NOT NULL,
	[LastStatusChange] [date] NULL,
	[DREntryCreated] [date] NOT NULL,
	[DREntryDeleted] [date] NULL,
	[ServiceType] [nvarchar](30) NULL,
	[DebtSequence] [int] NULL,
 CONSTRAINT [PK__DebtRecoveryAll] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[DebtRecovery_Live]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[DebtRecovery_Live](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DRProfile] [nvarchar](50) NOT NULL,
	[ContraventionID] [int] NOT NULL,
	[ContraventionNumber] [bigint] NOT NULL,
	[ContraventionStatus] [nvarchar](50) NOT NULL,
	[ZoneName] [nvarchar](150) NOT NULL,
	[ZoneSiteID] [int] NOT NULL,
	[LocationName] [nvarchar](250) NOT NULL,
	[DRCompany] [nvarchar](20) NOT NULL,
	[DRStatus] [nvarchar](100) NOT NULL,
	[PlacementLevel] [nvarchar](100) NOT NULL,
	[LastStatusChange] [date] NULL,
	[DREntryCreated] [date] NOT NULL,
	[DREntryDeleted] [date] NULL,
	[ServiceType] [nvarchar](30) NULL,
	[DebtSequence] [int] NULL,
 CONSTRAINT [PK__DebtReco__3214EC27B8858B45] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[DebtRecovery_Placements]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[DebtRecovery_Placements](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DREntryCreated] [date] NULL,
	[ServiceTypePrefix] [int] NULL,
	[DebtCollectionCompanyId] [int] NULL,
	[DRStatus] [nvarchar](50) NULL,
	[OutputType] [nvarchar](10) NULL,
	[PlacementLevel] [nvarchar](50) NULL,
	[1stPlacement] [int] NULL,
	[2ndPlacement] [int] NULL,
	[Litigation] [int] NULL,
	[TotalPlacements] [int] NULL,
	[Open] [int] NULL,
	[Cancelled] [int] NULL,
	[Paid] [int] NULL,
 CONSTRAINT [PK__DebtReco__3214EC27963F4E7C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[DebtRecovery_Predicted]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[DebtRecovery_Predicted](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [int] NOT NULL,
	[ActionOnDay] [int] NOT NULL,
	[DaysInProgress] [int] NOT NULL,
	[Days] [int] NOT NULL,
	[ToFirstPlacement] [int] NULL,
	[ToSecondPlacement] [int] NULL,
	[ToLitigation] [int] NULL,
 CONSTRAINT [PK_DebtRecovery_Predicted] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[DebtRecovery_PredictedPlacements]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[DebtRecovery_PredictedPlacements](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Days] [int] NULL,
	[ServiceTypePrefix] [int] NULL,
	[1stPlacement] [int] NULL,
	[2ndPlacement] [int] NULL,
	[Litigation] [int] NULL,
	[TotalPlacements] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[InternalDebtRecovery]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[InternalDebtRecovery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowName] [nvarchar](50) NULL,
	[Stage] [nvarchar](30) NULL,
	[AccountId] [int] NULL,
	[ContraventionId] [int] NULL,
	[ContraventionDate] [datetime] NULL,
	[InternalDebtDate] [datetime] NULL,
	[PendingDebtRecoveryDate] [datetime] NULL,
	[ContraventionType] [nvarchar](20) NULL,
	[ZoneId] [int] NULL,
	[PaymentAmount] [decimal](18, 2) NULL,
	[PaidAt] [datetime] NULL,
	[PaidDuringInternalDebt] [nvarchar](3) NULL,
	[DayOfPayment] [int] NULL,
 CONSTRAINT [PK__Internal__3214EC27764C8D0B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[iParkTransactions]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[iParkTransactions](
	[ID] [int] NOT NULL,
	[SiteID] [int] NULL,
	[Site] [nvarchar](255) NULL,
	[ClientLogin] [nvarchar](255) NULL,
	[LatestTransaction] [date] NULL,
	[FirstTransactionAgeDays] [bigint] NULL,
	[LastTransactionAgeHours] [bigint] NULL,
	[TotalTransactions] [bigint] NULL,
	[AverageDailyTransactions] [decimal](10, 2) NULL,
	[HasCurrentTabletIssue] [int] NULL,
	[Priority] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[iParkTransactions_AllData]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[iParkTransactions_AllData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[SiteName] [nvarchar](255) NULL,
	[Longitude] [decimal](10, 2) NULL,
	[Latitude] [decimal](10, 2) NULL,
	[SiteStatus] [nvarchar](20) NULL,
	[RecordedDateTime] [datetime] NULL,
	[LocationMatching] [nvarchar](10) NULL,
	[LocationOverstays] [nvarchar](10) NULL,
	[LocationVerifications] [nvarchar](10) NULL,
	[LocationTransfer] [nvarchar](10) NULL,
	[Priority] [nvarchar](10) NULL,
	[IsOnTechOps] [nvarchar](50) NULL,
	[HasCurrentTabletIssue] [nvarchar](10) NULL,
	[CurrentTabletIssue] [nvarchar](255) NULL,
	[CurrentTabletDescription] [nvarchar](max) NULL,
	[TotalTabletIssues] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[IssuedAndCancelledTickets]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[IssuedAndCancelledTickets](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PortfolioID] [int] NULL,
	[ZoneID] [int] NULL,
	[ZoneExternalReference] [int] NULL,
	[DDate] [date] NULL,
	[TotalIssued] [int] NULL,
	[TotalCancelled] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[LondonDistrictData]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[LondonDistrictData](
	[OBJECTID] [int] NOT NULL,
	[Shape] [nvarchar](50) NOT NULL,
	[postcode] [nvarchar](50) NOT NULL,
	[eastings] [int] NOT NULL,
	[northings] [int] NOT NULL,
	[ward14_nm] [nvarchar](50) NOT NULL,
	[ward14_cd] [nvarchar](50) NOT NULL,
	[boroughcd] [nvarchar](50) NOT NULL,
	[borough] [nvarchar](50) NOT NULL,
	[lsoa11_cd] [nvarchar](50) NOT NULL,
	[lsoa11_nm] [nvarchar](50) NOT NULL,
	[msoa11_cd] [nvarchar](50) NOT NULL,
	[msoa11_nm] [nvarchar](50) NOT NULL,
	[rgn11_cd] [nvarchar](50) NOT NULL,
	[rgn11_nm] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LondonDistrictData] PRIMARY KEY CLUSTERED 
(
	[OBJECTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[MasterReport_Stats]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[MasterReport_Stats](
	[ZoneName] [nvarchar](250) NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneId] [int] NOT NULL,
	[ZoneExternalReference2] [int] NULL,
	[AppealsLastYear] [int] NULL,
	[AppealsThisYear] [int] NULL,
	[SupportTicketsLastYear] [int] NULL,
	[SupportTicketsThisYear] [int] NULL,
	[AveAttritionLastYear] [decimal](18, 10) NULL,
	[AveAttritionThisYear] [decimal](18, 10) NULL,
	[TotalPermitsLastYear] [int] NULL,
	[TotalPermitsThisYear] [int] NULL,
	[CancellationsLastYear] [int] NULL,
	[CancellationsThisYear] [int] NULL,
	[TotalLocationsRetailLastYear] [int] NULL,
	[TotalLocationsRetailThisYear] [int] NULL,
	[TotalPCNsRetailLastYear] [int] NULL,
	[TotalPCNsRetailThisYear] [int] NULL,
	[TotalCancellationsRetailLastYear] [int] NULL,
	[TotalCancellationsRetailThisYear] [int] NULL,
	[TotalClientCancellationsLastYear] [int] NULL,
	[TotalClientCancellationsThisYear] [int] NULL,
 CONSTRAINT [PK_MasterReport_Stats] PRIMARY KEY CLUSTERED 
(
	[ZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[PCN_Revenue_CombinedExtranetStella_DONTUSE]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[PCN_Revenue_CombinedExtranetStella_DONTUSE](
	[Id] [int] NOT NULL,
	[SiteReference] [int] NULL,
	[SiteName] [nvarchar](255) NULL,
	[Date] [datetime2](7) NULL,
	[Year] [smallint] NULL,
	[Month] [smallint] NULL,
	[ServiceType] [nvarchar](20) NULL,
	[ExtranetRevenue] [decimal](18, 2) NULL,
	[StellaRevenue] [decimal](18, 2) NULL,
	[TotalRevenue] [decimal](18, 2) NULL,
	[TotalPaidStella] [int] NULL,
	[TotalPaidExtranet] [int] NULL,
	[TotalPaid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Sites]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Sites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneID] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[CompanyID] [int] NULL,
	[CompanyName] [nvarchar](200) NULL,
	[PortfolioID] [int] NULL,
	[PortfolioName] [nvarchar](200) NULL,
	[HasPortfolio] [nvarchar](10) NULL,
	[RegionName] [nvarchar](200) NULL,
	[SubRegionName] [nvarchar](200) NULL,
	[LocationStatus] [nvarchar](20) NULL,
	[ANPR] [bit] NULL,
	[PARKING OPS] [bit] NULL,
	[STS] [bit] NULL,
	[ITICKET] [bit] NULL,
	[ECAM] [bit] NULL,
	[CONTRAVENTION MANAGEMENT] [bit] NULL,
	[OTHER] [bit] NULL,
	[IPARK] [bit] NULL,
	[ITICKETLITE] [bit] NULL,
	[STSNEW] [bit] NULL,
	[KAM] [nvarchar](50) NULL,
	[System] [nvarchar](20) NULL,
	[Sector] [nvarchar](50) NULL,
	[ActiveDate] [datetime] NULL,
	[DeactiveDate] [datetime] NULL,
	[Longitude] [decimal](11, 8) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Postcode] [nvarchar](20) NULL,
	[TotalBays] [int] NULL,
	[DisabledBays] [int] NULL,
	[ParentToddlerBays] [int] NULL,
	[ElectricVehicleBays] [int] NULL,
	[Jurisdiction] [nvarchar](50) NULL,
	[TechOpsLocationID] [int] NULL,
	[ZoneType] [nvarchar](100) NULL,
	[AccountManager] [nvarchar](100) NULL,
	[HasHadANPR] [int] NULL,
	[SectorId] [int] NULL,
	[JurisdictionId] [int] NULL,
 CONSTRAINT [PK__Sites_Zo__60166795D5ACF809] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Sites_History_Detailed]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Sites_History_Detailed](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneID] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[CompanyID] [int] NULL,
	[CompanyName] [nvarchar](200) NULL,
	[PortfolioID] [int] NULL,
	[PortfolioName] [nvarchar](200) NULL,
	[HasPortfolio] [nvarchar](10) NULL,
	[RegionName] [nvarchar](200) NULL,
	[SubRegionName] [nvarchar](200) NULL,
	[LocationStatus] [nvarchar](20) NULL,
	[ANPR] [bit] NULL,
	[PARKING OPS] [bit] NULL,
	[STS] [bit] NULL,
	[ITICKET] [bit] NULL,
	[ECAM] [bit] NULL,
	[CONTRAVENTION MANAGEMENT] [bit] NULL,
	[OTHER] [bit] NULL,
	[KAM] [nvarchar](50) NULL,
	[System] [nvarchar](20) NULL,
	[Sector] [nvarchar](50) NULL,
	[ActiveDate] [datetime] NULL,
	[DeactiveDate] [datetime] NULL,
	[Longitude] [decimal](11, 8) NULL,
	[Latitude] [decimal](11, 8) NULL,
	[Postcode] [nvarchar](20) NULL,
	[TotalBays] [int] NULL,
	[DisabledBays] [int] NULL,
	[ParentToddlerBays] [int] NULL,
	[ElectricVehicleBays] [int] NULL,
	[Jurisdiction] [nvarchar](50) NULL,
	[TechOpsLocationID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Sites_History_Overview]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Sites_History_Overview](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DDate] [date] NULL,
	[PROSPECTIVE] [int] NULL,
	[LIVE] [int] NULL,
	[DECOMISSIONED] [int] NULL,
	[ON-HOLD] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Sites_ZoneServices]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Sites_ZoneServices](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NULL,
	[LocationName] [nvarchar](255) NULL,
	[ZoneId] [int] NULL,
	[ZoneName] [nvarchar](255) NULL,
	[ZoneReference] [int] NULL,
	[GoLiveDate] [datetime] NULL,
	[ServiceTypeId] [int] NULL,
 CONSTRAINT [PK__Sites_Zo__3214EC274E426957] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_Appeals]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_Appeals](
	[AppealID] [int] IDENTITY(1,1) NOT NULL,
	[AppealReceivedDate] [date] NULL,
	[AppealCreatedDate] [date] NULL,
	[AppealReference] [nvarchar](20) NULL,
	[AppealReason] [nvarchar](100) NULL,
	[AppealActioned] [nvarchar](20) NULL,
	[AppealActionedDate] [date] NULL,
	[AppealActionedUserID] [int] NULL,
	[AppealActionedUser] [nvarchar](50) NULL,
	[AppealStatus] [nvarchar](20) NULL,
	[AppealRejectReason] [nvarchar](50) NULL,
	[AppealsService] [nvarchar](20) NULL,
	[ContraventionID] [bigint] NULL,
	[ContraventionNumber] [bigint] NULL,
	[ContraventionStatus] [nvarchar](20) NULL,
	[IsDebtRecovery] [int] NULL,
	[ContraventionReason] [nvarchar](100) NULL,
	[POPLACreated] [nvarchar](10) NULL,
	[POPLACreatedDate] [date] NULL,
	[PoplaResult] [nvarchar](50) NULL,
	[PoplaResultDate] [date] NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[ZoneID] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[ZoneReference] [int] NULL,
	[AccountID] [int] NULL,
 CONSTRAINT [PK_Stella_Appeals_AppealsID] PRIMARY KEY CLUSTERED 
(
	[AppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_AppealsCorrespondence]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_AppealsCorrespondence](
	[AccountCorrespondenceID] [int] IDENTITY(1,1) NOT NULL,
	[AppealID] [int] NOT NULL,
	[ContraventionId] [bigint] NOT NULL,
	[ContraventionNumber] [bigint] NOT NULL,
	[CorrespondenceAction] [nvarchar](30) NULL,
	[CorrespondenceType] [nvarchar](30) NOT NULL,
	[SendMethod] [nvarchar](20) NOT NULL,
	[SendStatus] [nvarchar](20) NOT NULL,
	[CorrespondenceTemplate] [nvarchar](200) NULL,
	[CorrespondenceLetterDate] [date] NOT NULL,
	[CorrespondenceProcessedDate] [date] NULL,
	[CorrespondenceCreatedByID] [int] NULL,
	[CorrespondenceCreatedBy] [nvarchar](50) NULL,
	[LocationID] [int] NOT NULL,
	[LocationName] [nvarchar](200) NOT NULL,
	[ZoneID] [int] NOT NULL,
	[ZoneName] [nvarchar](200) NOT NULL,
	[ZoneReference] [int] NULL,
 CONSTRAINT [PK_Stella_AppealsCorrespondence_AppealCorrespondenceID] PRIMARY KEY CLUSTERED 
(
	[AccountCorrespondenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_PendingAppeals]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_PendingAppeals](
	[PendingAppealID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionId] [bigint] NOT NULL,
	[ContraventionNumber] [bigint] NOT NULL,
	[PendingAppealCreatedDate] [date] NOT NULL,
	[PendingAppealIsProcessed] [int] NOT NULL,
	[PendingAppealProcessedDate] [date] NULL,
	[PendingAppealProcessedByID] [int] NULL,
	[PendingAppealProcessedBy] [nvarchar](100) NULL,
	[LocationID] [int] NOT NULL,
	[LocationName] [nvarchar](100) NOT NULL,
	[ZoneID] [int] NOT NULL,
	[ZoneName] [nvarchar](100) NOT NULL,
	[ZoneReference] [int] NOT NULL,
	[WorkQueue] [nvarchar](75) NULL,
	[AppealSource] [nvarchar](50) NULL,
 CONSTRAINT [PK_Stella_PendingAppeals_PendingAppealID] PRIMARY KEY CLUSTERED 
(
	[PendingAppealID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_PendingAppealsLocks]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_PendingAppealsLocks](
	[LockID] [int] IDENTITY(1,1) NOT NULL,
	[LockCreated] [date] NOT NULL,
	[PendingAppealId] [int] NOT NULL,
	[LockedByID] [int] NULL,
	[LockedBy] [nvarchar](100) NOT NULL,
	[ProcessedByID] [int] NULL,
	[ProcessedBy] [nvarchar](100) NULL,
	[Processed] [date] NULL,
	[TimeTaken] [int] NULL,
	[LockSkipped] [int] NOT NULL,
	[LockActioned] [int] NOT NULL,
	[LockNotYetActioned] [int] NOT NULL,
	[ProcessedBySameUser] [nvarchar](10) NOT NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[ZoneID] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[ZoneReference] [nvarchar](10) NULL,
 CONSTRAINT [PK_Stella_PendingAllealsLocks_LockID] PRIMARY KEY CLUSTERED 
(
	[LockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_Users]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Stella_Users_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Stella_Verified]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Stella_Verified](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [int] NULL,
	[VerifiedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Transfer360]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Transfer360](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneExternalReference] [int] NULL,
	[Workflow] [nvarchar](250) NULL,
	[ServiceTypePrefix] [int] NULL,
	[NTKSentDate] [date] NULL,
	[DateIssued] [date] NULL,
	[DebtProvider] [nvarchar](50) NULL,
	[PaymentType] [nvarchar](50) NULL,
	[DVLASent] [nvarchar](50) NULL,
	[IsLeased] [nvarchar](50) NULL,
	[TotalContraventions] [int] NULL,
	[CashPaid] [decimal](18, 2) NULL,
	[PlacedWithDRCompany] [int] NULL,
	[Paid] [int] NULL,
	[Open] [int] NULL,
	[Cancelled] [int] NULL,
	[DVLALookups] [int] NULL,
	[NonDVLALookups] [int] NULL,
	[Leased] [int] NULL,
	[NonLeased] [int] NULL,
	[NTKSentTotal] [int] NULL,
	[UKPCPaid] [decimal](18, 2) NULL,
	[DebtCollectionPaid] [decimal](18, 2) NULL,
	[HasT360Lookup] [int] NULL,
 CONSTRAINT [PK__Transfer__3214EC274BFC3DBB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[Transfer360LeasedVehicles]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[Transfer360LeasedVehicles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContraventionID] [int] NULL,
	[NonLeased] [int] NULL,
	[Leased] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Statistics].[VehicleListPermits]    Script Date: 6/4/2025 10:26:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Statistics].[VehicleListPermits](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Plate] [nvarchar](200) NULL,
	[MasterCreatedDate] [datetime] NULL,
	[ValidateFrom] [datetime] NULL,
	[ValidateTo] [datetime] NULL,
	[ZoneID] [int] NULL,
	[ZoneExternalReference] [int] NULL,
	[ZoneName] [nvarchar](200) NULL,
	[RecurringType] [nvarchar](50) NULL,
	[PermitType] [nvarchar](50) NULL,
	[VehicleListName] [nvarchar](200) NULL,
 CONSTRAINT [PK__VehicleL__3214EC270106FC60] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContraventionID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContraventionID] ON [Statistics].[Contraventions]
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FirstIssuedDate]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_FirstIssuedDate] ON [Statistics].[Contraventions]
(
	[FirstIssuedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ZoneExternalReference]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ZoneExternalReference] ON [Statistics].[Contraventions]
(
	[ZoneExternalReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContraventionID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContraventionID] ON [Statistics].[Contraventions_Cancellations]
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [contravention_number]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [contravention_number] ON [Statistics].[Contraventions_Issued]
(
	[ContraventionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DateIssued]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_DateIssued] ON [Statistics].[Contraventions_Issued]
(
	[DateIssued] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServiceTypePrefix]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ServiceTypePrefix] ON [Statistics].[Contraventions_Issued]
(
	[Service_type_prefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ContraventionID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [idx_ContraventionID] ON [Statistics].[Contraventions_NTKs]
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContraventionID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContraventionID] ON [Statistics].[DebtRecovery_All]
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContraventionID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContraventionID] ON [Statistics].[DebtRecovery_Live]
(
	[ContraventionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ZoneExternalReference]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_ZoneExternalReference] ON [Statistics].[Sites]
(
	[ZoneExternalReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleListPermits_MasterCreatedDate_ValidateFrom_ValidateTo]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_VehicleListPermits_MasterCreatedDate_ValidateFrom_ValidateTo] ON [Statistics].[VehicleListPermits]
(
	[MasterCreatedDate] ASC,
	[ValidateFrom] ASC,
	[ValidateTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleListPermits_PermitType]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_VehicleListPermits_PermitType] ON [Statistics].[VehicleListPermits]
(
	[PermitType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleListPermits_Plate_ZoneID]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_VehicleListPermits_Plate_ZoneID] ON [Statistics].[VehicleListPermits]
(
	[Plate] ASC,
	[ZoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleListPermits_ZoneId]    Script Date: 6/4/2025 10:26:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_VehicleListPermits_ZoneId] ON [Statistics].[VehicleListPermits]
(
	[ZoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [development].[Dim_Date] ADD  DEFAULT ((0)) FOR [IsBankHoliday]
GO
ALTER TABLE [development].[Dim_Date] ADD  DEFAULT ((0)) FOR [IsWeekend]
GO
ALTER TABLE [development].[Dim_Date] ADD  DEFAULT ((0)) FOR [IsFollowingWorkingDay]
GO
ALTER TABLE [Reporting].[GOGWLateAppeal] ADD  DEFAULT ((0)) FOR [method]
GO
ALTER TABLE [KPI].[HR_Absence]  WITH CHECK ADD  CONSTRAINT [FK_KPIAbsence] FOREIGN KEY([KPI])
REFERENCES [KPI].[KPI] ([KPIID])
GO
ALTER TABLE [KPI].[HR_Absence] CHECK CONSTRAINT [FK_KPIAbsence]
GO
ALTER TABLE [KPI].[HR_Attrition]  WITH CHECK ADD  CONSTRAINT [FK_KPIAttrition] FOREIGN KEY([KPI])
REFERENCES [KPI].[KPI] ([KPIID])
GO
ALTER TABLE [KPI].[HR_Attrition] CHECK CONSTRAINT [FK_KPIAttrition]
GO
ALTER TABLE [Statistics].[Contraventions_ServiceTypes]  WITH CHECK ADD  CONSTRAINT [FK_Contraventions_ServiceTypes_Contraventions_ServiceTypes_ContraventionTypes] FOREIGN KEY([Contravention_type])
REFERENCES [Statistics].[Contraventions_ServiceTypes_ContraventionTypes] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Statistics].[Contraventions_ServiceTypes] CHECK CONSTRAINT [FK_Contraventions_ServiceTypes_Contraventions_ServiceTypes_ContraventionTypes]
GO
ALTER TABLE [Statistics].[Contraventions_ServiceTypes]  WITH CHECK ADD  CONSTRAINT [FK_Contraventions_ServiceTypes_Contraventions_ServiceTypes_Department] FOREIGN KEY([Department])
REFERENCES [Statistics].[Contraventions_ServiceTypes_Department] ([DepartmentID])
ON UPDATE CASCADE
GO
ALTER TABLE [Statistics].[Contraventions_ServiceTypes] CHECK CONSTRAINT [FK_Contraventions_ServiceTypes_Contraventions_ServiceTypes_Department]
GO

--
GO
USE [master]
GO
ALTER DATABASE [BusinessIntelligenceBankPark] SET  READ_WRITE 
GO
