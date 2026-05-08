USE FMCG_FIN_OLAP;
GO

CREATE TABLE dbo.FinancialPerformanceMart
(
    symbol           VARCHAR(10)  NOT NULL,
    company_name     VARCHAR(100) NOT NULL,
    year             INT          NOT NULL,
    quarter          VARCHAR(2)   NOT NULL,   

    sales            DECIMAL(18,2) NOT NULL,
    gross_profit     DECIMAL(18,2) NOT NULL,
    operating_profit DECIMAL(18,2) NOT NULL,
    pat              DECIMAL(18,2) NOT NULL,

    gp_margin        DECIMAL(5,2)  NOT NULL,
    op_margin        DECIMAL(5,2)  NOT NULL,
    eps              DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_FinancialPerformanceMart
        PRIMARY KEY (symbol, year, quarter)
);


INSERT INTO FMCG_FIN_OLAP.dbo.FinancialPerformanceMart
(
    symbol,
    company_name,
    year,
    quarter,
    sales,
    gross_profit,
    operating_profit,
    pat,
    gp_margin,
    op_margin,
    eps
)
SELECT
    Symbol,
    Company_Name,
    YEAR(Period)                  AS year,
    LEFT(Fiscal_Quarter, 2)        AS quarter,

    ROUND(SUM(Sales), 2)               AS sales,
    ROUND(SUM(Gross_Profit), 2)        AS gross_profit,
    ROUND(SUM(Operating_Profit), 2)    AS operating_profit,
    ROUND(SUM(Profit_After_Tax), 2)    AS pat,

    ROUND(AVG(Gross_Profit_Margin), 2)     AS gp_margin,
    ROUND(AVG(Operating_Profit_Margin), 2) AS op_margin,
    ROUND(AVG(Earnings_Per_Share_EPS), 2)  AS eps
FROM FMCG_FIN_OLTP.dbo.financials_fmcg
GROUP BY
    Symbol,
    Company_Name,
    YEAR(Period),
    LEFT(Fiscal_Quarter, 2);


