# 先前準備
- 安裝 Java SDK 1.7 或更高版本, 64 bits 的 windows 環境中測試過, 但尚未測試 32 bits 的 windows 環境
- 安裝 neo4j (安裝 community version 即可)
    - 請先從 https://neo4j.com/ 下載最新的 neo4j
    - 開啟 neo4j server 並登入: 開啟 neo4j 之後, 請用瀏覽器打開 http://127.0.0.1:7474/, 預設帳號密碼都是 neo4j, 第一次登入會要求重新設定密碼
- 準備要處理的 PLSQL 檔案
- 準備 TABLE_OWNER+TABLE_NAME定義檔, 該檔案有三個欄位, 第一個欄位為table owner, 第二個為table name, 第三個欄位是欄位名稱, 欄位用逗號分隔, 範例如下
```
ABC_REPL,CARDTYPE,CARDTYPE
ABC_REPL,CARDTYPE,CARDTYPE1
ABC_REPL,CARDTYPE,CARD2
```

# 如何執行
-下載在 deployment 這個目錄的所有 jar 檔案
## On windows (>: 命令提示字元)
### 設定 CLASSPATH
- 設定 CLASSPATH 環境變數
```
> set CLASSPATH="plsqltableparser.jar的絕對路徑";"antlr4-runtime-4.7.jar的絕對路徑";"hamcrest-core-1.3.jar的絕對路徑";"neo4j-java-driver-1.4.2.jar的絕對路徑"
```
- 範例: (假設plsqltableparser.jar放在D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment, 其他 jar 檔案放到 D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib )
```
> set CLASSPATH=D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\antlr4-runtime-4.7.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\hamcrest-core-1.3.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\neo4j-java-driver-1.4.2.jar
```
### 執行解析
#### I. 顯示 Table 關係
- 執行 PlsqlTableRelationParser 解析 (請注意 TABLE_OWNER+TABLE_NAME定義檔 理論上可以無限個)
```
> java PlsqlTableRelationParser NEO4J主機(長相為 bolt://127.0.0.1:PORT) NEO4J帳號 NEO4j密碼 需要處理的PL/SQL檔案絕對路徑 TABLE_OWNER+TABLE_NAME定義檔1 TABLE_OWNER+TABLE_NAME定義檔2 TABLE_OWNER+TABLE_NAME定義檔3 TABLE_OWNER+TABLE_NAME定義檔4 ... TABLE_OWNER+TABLE_NAME定義檔n
```
- 範例:
```
> java PlsqlTableRelationParser bolt://127.0.0.1:7687 neo4j帳號 neo4j密碼 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql  D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3 
ANTLR Tool version 4.4 used for code generation does not match the current runtime version 4.7ANTLR Tool version 4.4 used for code generation does not match the current runtime version 4.7line 774:0 extraneous input '/' expecting {<EOF>, ALTER, CREATE, DELETE, DROP, EXPLAIN, INSERT, LOCK, MERGE, SELECT, UPDATE, WITH, '('}
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3

------------------- Merge --------------------------
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.FS001_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.FS002_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.GD001_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.SC024_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.SC024_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.PB901_DAY
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.PB005_ME
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.PB005_ME
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:ODS_BANK.PB001_DAY
[destination:insert][delete target:delete][update target table:update][merge into destination table: merge]:ACCT_SAVING_TB
----------------- Data have been ingested by neo4j ---------------------------

```
- 當看到 "Data have been ingested by neo4j", 就可以在 neo4j 網頁介面, 下 CQL 驗證
```
1. 想要知道目前有多少 table: match (t) return t;
2. 想要知道有關係的 table 和相互關係: match (t)-[r] return t,r;
```
- 在 neo4j 會看到 edge 上面會有 downstream
- 範例
```
A - downstream -> B: 代表從 Table A 出來的資料會影響 Table B, 也代表 Table B 的資料會被 Table A 的資料所影響

```
3. 下面是一些常用的 CQL 語法
```
1. 查詢所有節點: match (t) return t
2. 刪除所有關係: match (t)-[r]-(q) delete r
3. 刪除所有節點: match (t) delete t
```
#### II. 顯示 Table 關係 - 進階版
- 執行 PlsqlTableScanner 解析 (請注意 TABLE_OWNER+TABLE_NAME定義檔 理論上可以無限個)
```
> java PlsqlTableScanner 需要處理的PL/SQL檔案絕對路徑或包含PL/SQL檔案的資料夾絕對路徑 輸出檔案絕對路徑 TABLE_OWNER+TABLE_NAME定義檔1 TABLE_OWNER+TABLE_NAME定義檔2 TABLE_OWNER+TABLE_NAME定義檔3 TABLE_OWNER+TABLE_NAME定義檔4 ... TABLE_OWNER+TABLE_NAME定義檔n
```
- 範例:
```
> java PlsqlTableScanner D:/temp/Dimensions/BNK_D_WMG/DM/DM_WMG/SP_WMG_VD_NCC_3M.sql D:/temp/Dimensions/result_5.log D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1.txt D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2.txt D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3.txt D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_4.txt D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_5.txt D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_6.txt

------------------- START ----------------------
Input SQL file path: D:/temp/Dimensions/BNK_D_WMG/DM/DM_WMG/SP_WMG_VD_NCC_3M.sql
Report file path: D:/temp/Dimensions/result_5.log
Table defintion list: 
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1.txt
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2.txt
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3.txt
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_4.txt
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_5.txt
	D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_6.txt

File path: D:/temp/Dimensions/BNK_D_WMG/DM/DM_WMG/SP_WMG_VD_NCC_3M.sql

----------------- Done ---------------------------

```


#### III. 顯示 Column - Table 關係
- 目前只能用來 mapping 如果 Column 是屬於同樣名稱的 table, 尚未能夠依照 PLSQL 所描述的關係建立關係
- 執行 PlsqlColumnTableRelationParser 解析 (請注意 TABLE_OWNER+TABLE_NAME定義檔 理論上可以無限個)
```
> java PlsqlColumnTableRelationParser NEO4J主機(長相為 bolt://127.0.0.1:PORT) NEO4J帳號 NEO4j密碼 需要處理的PL/SQL檔案絕對路徑 TABLE_OWNER+TABLE_NAME定義檔1 TABLE_OWNER+TABLE_NAME定義檔2 TABLE_OWNER+TABLE_NAME定義檔3 TABLE_OWNER+TABLE_NAME定義檔4 ... TABLE_OWNER+TABLE_NAME定義檔n
```
- 範例:
```
> java PlsqlColumnTableRelationParser bolt://127.0.0.1:7687 neo4j帳號 neo4j密碼 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql  D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3 
ANTLR Tool version 4.4 used for code generation does not match the current runtime version 4.7ANTLR Tool version 4.4 used for code generation does not match the current runtime version 4.7line 774:0 extraneous input '/' expecting {<EOF>, ALTER, CREATE, DELETE, DROP, EXPLAIN, INSERT, LOCK, MERGE, SELECT, UPDATE, WITH, '('}
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_4
Read content from file: D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_5

------------------- Insert --------------------------
[source:insert][delete source table:delete][update source table: update][merge source table: merge]:CREDIT_CTI.AG_MAILDOCUMENTS
[destination:insert][delete target:delete][update target table:update][merge into destination table: merge]:ODS_BANK.AG_MAILDOCUMENTS
------------------ Creating destination table:ODS_BANK.AG_MAILDOCUMENTS in neo4j -------------------------
------------------ Creating source table:CREDIT_CTI.AG_MAILDOCUMENTS in neo4j -------------------------
------- Trying to match column by column name -----
match (t:Table)-[r:HAVE]-(c:Column) return t,r,c;
----------------- Data have been ingested by neo4j ---------------------------

```
- 當看到 "Data have been ingested by neo4j", 就可以在 neo4j 網頁介面, 下 CQL 驗證
```
1. 想要知道目前有多少 table: match (t) return t;
2. 想知道那些 table 有 Column 名稱是 WHEN_UPDATE: match (t)-[r:HAVE]->(c:Column {Name:"WHEN_UPDATE"}) return (t),r,c;
```
- 在 neo4j 會看到 edge 上面會有 HAVE 和 DOWNSTREAM
```
HAVE: Table 擁有 (HAVE) 欄位 (COLUMN)
DOWNSTREAM: 代表不同 Table 關係: A - HAVE -> COLUMN_A - downstream -> COLUMN_B <- HAVE - B: 代表從 Table A 出來的 COLUMN_A 欄位資料會影響 Table B 的 COLUMN_B 資料
```
3. 下面是一些常用的 CQL 語法
```
1. 查詢所有節點: match (t) return t
2. 刪除所有關係: match (t)-[r]-(q) delete r
3. 刪除所有節點: match (t) delete t
```
### P.S
- 一次只能執行 Table 關係檢視和 Table - Column 關係檢視其中一個, 建議可以利用換 neo4j database 來改變, 換句話說, 一個 database 存放 table 關係, 另外一個 database 存放 table-column 關係,  可以參考 [Stack Overflow](https://stackoverflow.com/questions/10888280/neo4j-how-to-switch-database) 了解如何使用
- 目前知道有下列問題
```
1. 如果欄位名稱是中文時, 解析可能會發生問題
2. 如果要解析的 PL/SQL 檔案是用 MS950 編碼, 也會發生問題, 比較保險的方式是所有的檔案都是 UTF-8 編碼, 包含要解析的 PL/SQL 檔案及 TABLE_OWBER+TABLE_NAME定義檔.
```
## On linux&Mac
### TBD

# References
1. Neo4j: https://neo4j.com/
2. CQL: https://neo4j.com/developer/cypher-query-language/
3. Antlr: http://www.antlr.org/
