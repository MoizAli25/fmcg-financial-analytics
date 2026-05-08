use FMCG_FIN_OLAP

CREATE TABLE dbo.DividendPayoutMart
(
    symbol                 VARCHAR(10)  NOT NULL,
    company_name           VARCHAR(100) NOT NULL,
    year                   INT          NOT NULL,
    quarter                VARCHAR(2)   NOT NULL,

    dps                    DECIMAL(10,2) NOT NULL,
    payout_ratio           DECIMAL(5,2)  NOT NULL,
    net_assets_per_share   DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_DividendPayoutMart
        PRIMARY KEY (symbol, year, quarter)
);

INSERT INTO FMCG_FIN_OLAP.dbo.DividendPayoutMart
(
    symbol,
    company_name,
    year,
    quarter,
    dps,
    payout_ratio,
    net_assets_per_share
)
SELECT
    Symbol,
    Company_Name,
    YEAR(Period)           AS year,
    LEFT(Fiscal_Quarter,2) AS quarter,

    ROUND(AVG(Dividend_Per_Share_Total), 2) AS dps,
    ROUND(AVG(Dividend_Payout_Ratio), 2)    AS payout_ratio,
    ROUND(AVG(Net_Assets_Per_Share), 2)     AS net_assets_per_share
FROM FMCG_FIN_OLTP.dbo.financials_fmcg
GROUP BY
    Symbol,
    Company_Name,
    YEAR(Period),
    LEFT(Fiscal_Quarter, 2);


    select * from FMCG_FIN_OLAP.dbo.DividendPayoutMart