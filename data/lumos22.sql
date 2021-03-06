USE [lumos22]
GO
/****** Object:  Table [dbo].[podio_hooks_]    Script Date: 11.05.2022 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[podio_hooks_](
	[id] [int] NOT NULL,
	[email] [nvarchar](50) NULL,
	[group_id] [nvarchar](100) NULL,
	[utm_source] [nvarchar](50) NULL,
	[utm_medium] [nvarchar](50) NULL,
	[utm_campaign] [nvarchar](50) NULL,
	[utm_content] [nvarchar](50) NULL,
	[utm_term] [nvarchar](50) NULL,
	[created_at] [datetime2](7) NULL,
	[date] [datetime2](7) NULL,
	[coach] [nvarchar](50) NULL,
	[created_at_3h] [datetime2](7) NULL,
	[group_type] [nvarchar](50) NULL,
	[connect] [nvarchar](50) NULL,
	[utm] [nvarchar](50) NULL,
	[utm_4] [nvarchar](50) NULL,
	[utm_3] [nvarchar](50) NULL,
	[utm_2] [nvarchar](50) NULL,
	[utm_1] [nvarchar](50) NULL,
	[email_lower] [nvarchar](50) NULL,
	[Column_21] [tinyint] NULL,
	[connect_test] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[podio_payments]    Script Date: 11.05.2022 23:03:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[podio_payments](
	[id] [int] NOT NULL,
	[account] [varchar](max) NULL,
	[payment_id] [int] NULL,
	[user_name] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[order_number] [int] NULL,
	[creation_date] [datetime2](7) NULL,
	[type] [varchar](max) NULL,
	[status] [varchar](max) NULL,
	[amount] [float] NULL,
	[commissions] [varchar](max) NULL,
	[received] [varchar](max) NULL,
	[title] [varchar](max) NULL,
	[podio_user] [varchar](max) NULL,
	[creation_date_3h] [datetime2](7) NULL,
	[groups] [varchar](max) NULL,
	[class] [varchar](max) NULL,
	[email_lower] [varchar](max) NULL,
	[start_group] [varchar](max) NULL,
	[connection] [varchar](max) NULL,
	[returned_date] [datetime] NULL,
 CONSTRAINT [PK_podio_payments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
