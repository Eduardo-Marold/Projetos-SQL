select t.* from rfa_version_control t ORDER BY ID DESC;

SELECT * FROM RFAINTEGR.RFA_DEAL_CONTROL;     -- Tabela para controle de integração de DEALS a nível de HEADER.

SELECT * FROM RFAINTEGR.RFA_DEAL_DTL_CONTROL; -- Tabela para controle de integração de DEALS a nível de DETAIL.

/*Criação da package RFA_EXTERNAL_SUB_SQL. O propósito dessa package é fazer chamadas dos WebServices REPORTS de 
DEALS do RMS Cloud e persistir as mensagens da família RFA_DEAL na tabela INTEGRATION_MESSAGE do RFA. Foram criado 
as funções BUILD_DEAL_INFO e SEND_DEAL_INFO.*/

SELECT * FROM apex_ws_options WHERE webservice_ID IN (4, 5); -- Configuração dos serviços da package RFA_EXTERNAL_SUB_SQL.
/*Para a chamada dos WebServices, foi inserido as linhas de configuração dos dois serviços na tabela APEX_WS_OPTIONS.​
Conforme descrito no releasenote, os valores utilizados para os campos WEBSERVICE_ID e URL para cada serviço, foram:​

Para a operação DEALS_HEADER​
WEBSERVICE_ID = 4​
URL = https://fset-stage-mfcs-obi.oracleindustry.com/xmlpserver/services/rest/v1/reports/Guest%2FRMS%2FDeals%2Fother%2Finvoice/run​

Para a operação DEALS_DETAIL​
WEBSERVICE_ID = 5​
URL = https://fset-stage-mfcs-obi.oracleindustry.com/xmlpserver/services/rest/v1/reports/Guest%2FRMS%2FDeals%2Fother%2Finvoice_detail/run*/

-- Criação dos Job’s EXEC_RFA_EXTERNAL_SUB_SQL_BUILD e EXEC_RFA_EXTERNAL_SUB_SQL_SEND.
-- O propósito desses Jobs, é a execução das funções BUILD_DEAL_INFO e SEND_DEAL_INFO da package RFA_EXTERNAL_SUB_SQL.

-- Configuração RFA_EXTERNAL_SUB_SQL.
/*Para a chamada dos WebServices, foi inserido as linhas de configuração dos dois serviços na tabela APEX_WS_OPTIONS.​
Esses Job’s devem executar uma vez ao dia (horário a definir).​
Conforme descrito no releasenote, os valores utilizados para os campos WEBSERVICE_ID e URL para cada serviço, foram:​

Para a operação DEALS_HEADER​
WEBSERVICE_ID = 4​
URL = https://fset-stage-mfcs-obi.oracleindustry.com/xmlpserver/services/rest/v1/reports/Guest%2FRMS%2FDeals%2Fother%2Finvoice/run​

Para a operação DEALS_DETAIL​
WEBSERVICE_ID = 5​
URL = https://fset-stage-mfcs-obi.oracleindustry.com/xmlpserver/services/rest/v1/reports/Guest%2FRMS%2FDeals%2Fother%2Finvoice_detail/run*/

