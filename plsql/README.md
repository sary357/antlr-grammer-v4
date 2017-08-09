# 先前準備
- 安裝 Java SDK 1.7 或更高版本, 64 bits 的 windows 環境中測試過, 但尚未測試 32 bits 的 windows 環境
- 安裝 neo4j (安裝 community version 即可)
    - 請先從 https://neo4j.com/ 下載最新的 neo4j
    - 開啟 neo4j server 並登入: 開啟 neo4j 之後, 請用瀏覽器打開 http://127.0.0.1:7474/, 預設帳號密碼都是 neo4j, 第一次登入會要求重新設定密碼
- 準備要處理的 PLSQL 檔案
- 準備 TABLE_OWNER+TABLE_NAME定義檔, 該檔案有三個欄位, 第一個欄位為table owner, 第二個為table name, 第三個欄位是欄位名稱, 範例如下
```
ABC_REPL,CARDTYPE,CARDTYPE
ABC_REPL,CARDTYPE,CARDTYPE1
ABC_REPL,CARDTYPE,CARD2
```

# 如何執行
-下載在 deployment 這個目錄的所有 jar 檔案
## On windows ($: command prompt)
### 設定 CLASSPATH
- 設定 CLASSPATH 環境變數
```
$ set CLASSPATH="plsqltableparser.jar的絕對路徑";"antlr4-runtime-4.7.jar的絕對路徑";"hamcrest-core-1.3.jar的絕對路徑";"neo4j-java-driver-1.4.2.jar的絕對路徑"
```
- 範例: (假設plsqltableparser.jar放在D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment, 其他 jar 檔案放到 D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib )
```
$ set CLASSPATH=D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\antlr4-runtime-4.7.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\hamcrest-core-1.3.jar;D:\fuming.Tsai\Documents\Tools\PortableGit\projects\grammars-v4\plsql\deployment\plsqltableparser_lib\neo4j-java-driver-1.4.2.jar
```
### 執行解析
- 執行 PlsqlTableRelationParser 解析 
```
$ java PlsqlTableRelationParser NEO4J主機(長相為 bolt://127.0.0.1:PORT) NEO4J帳號 NEO4j密碼 需要處理的PL/SQL檔案絕對路徑 TABLE_OWNER+TABLE_NAME定義檔1 TABLE_OWNER+TABLE_NAME定義檔2 TABLE_OWNER+TABLE_NAME定義檔3 TABLE_OWNER+TABLE_NAME定義檔4 ... TABLE_OWNER+TABLE_NAME定義檔n
```
- 範例:
```
$ java PlsqlTableRelationParser bolt://127.0.0.1:7687 neo4j帳號 neo4j密碼 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql  D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_1 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_2 D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/table_list_3 
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
### 驗證: 
- 當看到 "Data have been ingested by neo4j", 就可以在 neo4j 網頁介面, 可以下 CQL 驗證
```
1. 想要知道目前有多少 table: match (t) return t;
2. 想要知道有關係的 table 和相互關係: match (t)-[r] return t,r;
```
- 在 neo4j 會看到 edge 上面會有 downstream 和 upstream, upstream 的起始會是被影響的 table, 也就是 downstream 中的下游, upstream 的終點是影響對方的 table, 也就是 downstream 的上游
- 範例
```
A - downstream -> B: 代表從 Table A 出來的資料會影響 Table B, 也代表 Table B 的資料會被 Table A 的資料所影響
C - upstream -> D:  代表從 Table D 出來的資料會影響 table C, 也代表 Table C 的資料會被 Table D 的資料所影響
```
3. 為避免跑完多次解析之後, 圖會變成不容易解讀, 建議每隔幾次或是每一次就要刪除所有節點, 以下是CQL用法
```
1. 查詢所有節點: match (t) return t
2. 刪除所有關係: match (t)-[r]-(q) delete r
3. 刪除所有節點: match (t) delete t
```
4. downstream 和 upstream 定義剛好相反, 理論上要成對出現, 如果沒有成對出現, 請跟我說

## On linux
### TBD
