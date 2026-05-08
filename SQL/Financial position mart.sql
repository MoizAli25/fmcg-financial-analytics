use FMCG_FIN_OLAP

CREATE TABLE dbo.FinancialPositionMart
(
    symbol                    VARCHAR(10)  NOT NULL,
    company_name              VARCHAR(100) NOT NULL,
    year                      INT          NOT NULL,
    quarter                   VARCHAR(2)   NOT NULL,

    current_assets            DECIMAL(18,2) NOT NULL,
    non_current_assets        DECIMAL(18,2) NOT NULL,
    current_liabilities       DECIMAL(18,2) NOT NULL,
    non_current_liabilities   DECIMAL(18,2) NOT NULL,
    net_assets                DECIMAL(18,2) NOT NULL,

    CONSTRAINT PK_FinancialPositionMart
        PRIMARY KEY (symbol, year, quarter)
);

INSERT INTO FMCG_FIN_OLAP.dbo.FinancialPositionMart
(
    symbol,
    company_name,
    year,
    quarter,
    current_assets,
    non_current_assets,
    current_liabilities,
    non_current_liabilities,
    net_assets
)
SELECT
    Symbol,
    Company_Name,
    YEAR(Period)           AS year,
    LEFT(Fiscal_Quarter,2) AS quarter,

    ROUND(SUM(Current_Assets), 2)          AS current_assets,
    ROUND(SUM(Non_Current_Assets), 2)      AS non_current_assets,
    ROUND(SUM(Current_Liabilities), 2)     AS current_liabilities,
    ROUND(SUM(Non_Current_Liabilities), 2) AS non_current_liabilities,
    ROUND(SUM(Net_Assets), 2)               AS net_assets
FROM FMCG_FIN_OLTP.dbo.financials_fmcg
GROUP BY
    Symbol,
    Company_Name,
    YEAR(Period),
    LEFT(Fiscal_Quarter, 2);


