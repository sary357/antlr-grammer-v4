/**
 *  * Oracle(c) PL/SQL 11g Parser
 *
 * Copyright (c) 2009-2011 Alexandre Porcelli <alexandre.porcelli@gmail.com>
 * Copyright (c) 2015-2017 Ivan Kochurkin (KvanTTT, kvanttt@gmail.com, Positive Technologies).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

lexer grammar PlSqlLexer;

A_LETTER:                     'A' |'a';
ADD:                          'ADD' |'add';
AFTER:                        'AFTER' |'after';
AGENT:                        'AGENT' |'agent';
AGGREGATE:                    'AGGREGATE' |'aggregate';
ALL:                          'ALL' |'all';
ALTER:                        'ALTER' |'alter';
ANALYZE:                      'ANALYZE' |'analyze';
AND:                          'AND' |'and';
ANY:                          'ANY' |'any';
ARRAY:                        'ARRAY' |'array';
AS:                           'AS' |'as';
ASC:                          'ASC' |'asc';
ASSOCIATE:                    'ASSOCIATE' |'associate';
AT:                           'AT'|'at';
ATTRIBUTE:                    'ATTRIBUTE' |'attribute';
AUDIT:                        'AUDIT' |'audit';
AUTHID:                       'AUTHID' |'authid';
AUTO:                         'AUTO' |'auto';
AUTOMATIC:                    'AUTOMATIC' |'automatic';
AUTONOMOUS_TRANSACTION:       'AUTONOMOUS_TRANSACTION' |'autonomous_transaction';
BATCH:                        'BATCH'|'batch';
BEFORE:                       'BEFORE'|'before';
BEGIN:                        'BEGIN'|'begin';
BETWEEN:                      'BETWEEN'|'between';
BFILE:                        'BFILE'|'bfile';
BINARY_DOUBLE:                'BINARY_DOUBLE'|'binary_double';
BINARY_FLOAT:                 'BINARY_FLOAT'|'binary_float';
BINARY_INTEGER:               'BINARY_INTEGER'|'binary_integer';
BLOB:                         'BLOB'|'blob';
BLOCK:                        'BLOCK'|'block';
BODY:                         'BODY'|'body';
BOOLEAN:                      'BOOLEAN'|'boolean';
BOTH:                         'BOTH'|'both';
BREADTH:                      'BREADTH'|'breadth';
BULK:                         'BULK'|'bulk';
BY:                           'BY'|'by';
BYTE:                         'BYTE'|'byte';
C_LETTER:                     'C'|'c';
CACHE:                        'CACHE'|'cache';
CALL:                         'CALL'|'call';
CANONICAL:                    'CANONICAL'|'canonical';
CASCADE:                      'CASCADE'|'cascade';
CASE:                         'CASE'|'case';
CAST:                         'CAST'|'cast';
CHAR:                         'CHAR'|'char';
CHAR_CS:                      'CHAR_CS'|'char_cs';
CHARACTER:                    'CHARACTER'|'character';
CHECK:                        'CHECK'|'check';
CHR:                          'CHR'|'chr';
CLOB:                         'CLOB'|'clob';
CLOSE:                        'CLOSE'|'close';
CLUSTER:                      'CLUSTER'|'cluster';
COALESCE:                     'COALESCE'|'coalesce';
COLLECT:                      'COLLECT'|'collect';
COLUMNS:                      'COLUMNS'|'columns';
COMMENT:                      'COMMENT'|'comment';
COMMIT:                       'COMMIT'|'commit';
COMMITTED:                    'COMMITTED'|'committed';
COMPATIBILITY:                'COMPATIBILITY'|'compatibility';
COMPILE:                      'COMPILE'|'compile';
COMPOUND:                     'COMPOUND'|'compound';
CONNECT:                      'CONNECT'|'connect';
CONNECT_BY_ROOT:              'CONNECT_BY_ROOT'|'connect_by_root';
CONSTANT:                     'CONSTANT'|'constant';
CONSTRAINT:                   'CONSTRAINT'|'constraint';
CONSTRAINTS:                  'CONSTRAINTS'|'constraints';
CONSTRUCTOR:                  'CONSTRUCTOR'|'constructor';
CONTENT:                      'CONTENT'|'content';
CONTEXT:                      'CONTEXT'|'context';
CONTINUE:                     'CONTINUE'|'continue';
CONVERT:                      'CONVERT'|'convert';
CORRUPT_XID:                  'CORRUPT_XID'|'corrupt_xid';
CORRUPT_XID_ALL:              'CORRUPT_XID_ALL'|'corrupt_xid_all';
COST:                         'COST'|'cost';
COUNT:                        'COUNT'|'count';
CREATE:                       'CREATE'|'create';
CROSS:                        'CROSS'|'cross';
CUBE:                         'CUBE'|'cube';
CURRENT:                      'CURRENT'|'current';
CURRENT_USER:                 'CURRENT_USER'|'current_user';
CURSOR:                       'CURSOR'|'cursor';
CUSTOMDATUM:                  'CUSTOMDATUM'|'customdatum';
CYCLE:                        'CYCLE'|'cycle';
DATA:                         'DATA'|'data';
DATABASE:                     'DATABASE'|'database';
DATE:                         'DATE'|'date';
DAY:                          'DAY'|'day';
DB_ROLE_CHANGE:               'DB_ROLE_CHANGE'|'db_role_change';
DBTIMEZONE:                   'DBTIMEZONE'|'dbtimezone';
DDL:                          'DDL'|'ddl';
DEBUG:                        'DEBUG'|'debug';
DEC:                          'DEC'|'dec';
DECIMAL:                      'DECIMAL'|'decimal';
DECLARE:                      'DECLARE'|'declare';
DECOMPOSE:                    'DECOMPOSE'|'decompose';
DECREMENT:                    'DECREMENT'|'decrement';
DEFAULT:                      'DEFAULT'|'default';
DEFAULTS:                     'DEFAULTS'|'defaults';
DEFERRED:                     'DEFERRED'|'deferred';
DEFINER:                      'DEFINER'|'definer';
DELETE:                       'DELETE'|'delete';
DEPTH:                        'DEPTH'|'depth';
DESC:                         'DESC'|'desc';
DETERMINISTIC:                'DETERMINISTIC'|'deterministic';
DIMENSION:                    'DIMENSION'|'dimension';
DISABLE:                      'DISABLE'|'disable';
DISASSOCIATE:                 'DISASSOCIATE'|'disassociate';
DISTINCT:                     'DISTINCT'|'distinct';
DOCUMENT:                     'DOCUMENT'|'document';
DOUBLE:                       'DOUBLE'|'double';
DROP:                         'DROP'|'drop';
DSINTERVAL_UNCONSTRAINED:     'DSINTERVAL_UNCONSTRAINED'|'dsinterval_unconstrained';
EACH:                         'EACH'|'each';
ELEMENT:                      'ELEMENT'|'element';
ELSE:                         'ELSE'|'else';
ELSIF:                        'ELSIF'|'elsif';
EMPTY:                        'EMPTY'|'empty';
ENABLE:                       'ENABLE'|'enable';
ENCODING:                     'ENCODING'|'encoding';
END:                          'END'|'end';
ENTITYESCAPING:               'ENTITYESCAPING'|'entityescaping';
ERR:                          'ERR'|'err';
ERRORS:                       'ERRORS'|'errors';
ESCAPE:                       'ESCAPE'|'escape';
EVALNAME:                     'EVALNAME'|'evalname';
EXCEPTION:                    'EXCEPTION'|'exception';
EXCEPTION_INIT:               'EXCEPTION_INIT'|'exception_init';
EXCEPTIONS:                   'EXCEPTIONS'|'exceptions';
EXCLUDE:                      'EXCLUDE'|'exclude';
EXCLUSIVE:                    'EXCLUSIVE'|'exclusive';
EXECUTE:                      'EXECUTE'|'execute';
EXISTS:                       'EXISTS'|'exists';
EXIT:                         'EXIT'|'exit';
EXPLAIN:                      'EXPLAIN'|'explain';
EXTERNAL:                     'EXTERNAL'|'external';
EXTRACT:                      'EXTRACT'|'extract';
FAILURE:                      'FAILURE'|'failure';
FALSE:                        'FALSE'|'false';
FETCH:                        'FETCH'|'fetch';
FINAL:                        'FINAL'|'final';
FIRST:                        'FIRST'|'first';
FIRST_VALUE:                  'FIRST_VALUE'|'first_value';
FLOAT:                        'FLOAT'|'float';
FOLLOWING:                    'FOLLOWING'|'following';
FOLLOWS:                      'FOLLOWS'|'follows';
FOR:                          'FOR'|'for';
FORALL:                       'FORALL'|'forall';
FORCE:                        'FORCE'|'force';
FROM:                         'FROM'|'from';
FULL:                         'FULL'|'full';
FUNCTION:                     'FUNCTION'|'function';
GOTO:                         'GOTO'|'goto';
GRANT:                        'GRANT'|'grant';
GROUP:                        'GROUP'|'group';
GROUPING:                     'GROUPING'|'grouping';
HASH:                         'HASH'|'hash';
HAVING:                       'HAVING'|'having';
HIDE:                         'HIDE'|'hide';
HOUR:                         'HOUR'|'hour';
IF:                           'IF'|'if';
IGNORE:                       'IGNORE'|'ignore';
IMMEDIATE:                    'IMMEDIATE'|'immediate';
IN:                           'IN'|'in';
INCLUDE:                      'INCLUDE'|'include';
INCLUDING:                    'INCLUDING'|'including';
INCREMENT:                    'INCREMENT'|'increment';
INDENT:                       'INDENT'|'indent';
INDEX:                        'INDEX'|'index';
INDEXED:                      'INDEXED'|'indexed';
INDICATOR:                    'INDICATOR'|'indicator';
INDICES:                      'INDICES'|'indices';
INFINITE:                     'INFINITE'|'infinite';
INLINE:                       'INLINE'|'inline';
INNER:                        'INNER'|'inner';
INOUT:                        'INOUT'|'inout';
INSERT:                       'INSERT'|'insert';
INSTANTIABLE:                 'INSTANTIABLE'|'instantiable';
INSTEAD:                      'INSTEAD'|'instead';
INT:                          'INT'|'int';
INTEGER:                      'INTEGER'|'integer';
INTERSECT:                    'INTERSECT'|'intersect';
INTERVAL:                     'INTERVAL'|'interval';
INTO:                         'INTO'|'into';
INVALIDATE:                   'INVALIDATE'|'invalidate';
IS:                           'IS'|'is';
ISOLATION:                    'ISOLATION'|'isolation';
ITERATE:                      'ITERATE'|'iterate';
JAVA:                         'JAVA'|'java';
JOIN:                         'JOIN'|'join';
KEEP:                         'KEEP'|'keep';
LANGUAGE:                     'LANGUAGE'|'language';
LAST:                         'LAST'|'last';
LAST_VALUE:                   'LAST_VALUE'|'last_value';
LEADING:                      'LEADING'|'leading';
LEFT:                         'LEFT'|'left';
LEVEL:                        'LEVEL'|'level';
LIBRARY:                      'LIBRARY'|'library';
LIKE:                         'LIKE'|'like';
LIKE2:                        'LIKE2'|'like2';
LIKE4:                        'LIKE4'|'like4';
LIKEC:                        'LIKEC'|'likec';
LIMIT:                        'LIMIT'|'limit';
LOCAL:                        'LOCAL'|'local';
LOCK:                         'LOCK'|'lock';
LOCKED:                       'LOCKED'|'locked';
LOG:                          'LOG'|'log';
LOGOFF:                       'LOGOFF'|'logoff';
LOGON:                        'LOGON'|'logon';
LONG:                         'LONG'|'long';
LOOP:                         'LOOP'|'loop';
MAIN:                         'MAIN'|'main';
MAP:                          'MAP'|'map';
MATCHED:                      'MATCHED'|'matched';
MAXVALUE:                     'MAXVALUE'|'maxvalue';
MEASURES:                     'MEASURES'|'measures';
MEMBER:                       'MEMBER'|'member';
MERGE:                        'MERGE'|'merge';
MINUS:                        'MINUS'|'minus';
MINUTE:                       'MINUTE'|'minute';
MINVALUE:                     'MINVALUE'|'minvalue';
MLSLABEL:                     'MLSLABEL'|'mlslabel';
MODE:                         'MODE'|'mode';
MODEL:                        'MODEL'|'model';
MODIFY:                       'MODIFY'|'modify';
MONTH:                        'MONTH'|'month';
MULTISET:                     'MULTISET'|'multiset';
NAME:                         'NAME'|'name';
NAN:                          'NAN'|'nan';
NATURAL:                      'NATURAL'|'natural';
NATURALN:                     'NATURALN'|'naturaln';
NAV:                          'NAV'|'nav';
NCHAR:                        'NCHAR'|'nchar';
NCHAR_CS:                     'NCHAR_CS'|'nchar_cs';
NCLOB:                        'NCLOB'|'nclob';
NESTED:                       'NESTED'|'nested';
NEW:                          'NEW'|'new';
NO:                           'NO'|'no';
NOAUDIT:                      'NOAUDIT'|'noaudit';
NOCACHE:                      'NOCACHE'|'nocache';
NOCOPY:                       'NOCOPY'|'nocopy';
NOCYCLE:                      'NOCYCLE'|'nocycle';
NOENTITYESCAPING:             'NOENTITYESCAPING'|'noentityescaping';
NOMAXVALUE:                   'NOMAXVALUE'|'nomaxvalue';
NOMINVALUE:                   'NOMINVALUE'|'nominvalue';
NONE:                         'NONE'|'none';
NOORDER:                      'NOORDER'|'noorder';
NOSCHEMACHECK:                'NOSCHEMACHECK'|'noschemacheck';
NOT:                          'NOT'|'not';
NOWAIT:                       'NOWAIT'|'nowait';
NULL:                         'NULL'|'null';
NULLS:                        'NULLS'|'nulls';
NUMBER:                       'NUMBER'|'number';
NUMERIC:                      'NUMERIC'|'numeric';
NVARCHAR2:                    'NVARCHAR2'|'nvarchar2';
OBJECT:                       'OBJECT'|'object';
OF:                           'OF'|'of';
OFF:                          'OFF'|'off';
OID:                          'OID'|'oid';
OLD:                          'OLD'|'old';
ON:                           'ON'|'on';
ONLY:                         'ONLY'|'only';
OPEN:                         'OPEN'|'open';
OPTION:                       'OPTION'|'option';
OR:                           'OR'|'or';
ORADATA:                      'ORADATA'|'oradata';
ORDER:                        'ORDER'|'order';
ORDINALITY:                   'ORDINALITY'|'ordinality';
OSERROR:                      'OSERROR'|'oserror';
OUT:                          'OUT'|'out';
OUTER:                        'OUTER'|'outer';
OVER:                         'OVER'|'over';
OVERRIDING:                   'OVERRIDING'|'overriding';
PACKAGE:                      'PACKAGE'|'package';
PARALLEL_ENABLE:              'PARALLEL_ENABLE'|'parallel_enable';
PARAMETERS:                   'PARAMETERS'|'parameters';
PARENT:                       'PARENT'|'parent';
PARTITION:                    'PARTITION'|'partition';
PASSING:                      'PASSING'|'passing';
PATH:                         'PATH'|'path';
PERCENT_ISOPEN:               '%ISOPEN'|'%isopen';
PERCENT_FOUND:                '%FOUND'|'%found';
PERCENT_NOTFOUND:             '%NOTFOUND'|'%notfound';
PERCENT_ROWCOUNT:             '%ROWCOUNT'|'%rowcount';
PERCENT_ROWTYPE:              '%ROWTYPE'|'%rowtype';
PERCENT_TYPE:                 '%TYPE'|'%type';
PIPELINED:                    'PIPELINED'|'pipelined';
PIVOT:                        'PIVOT'|'pivot';
PLAN:                         'PLAN'|'plan';
PLS_INTEGER:                  'PLS_INTEGER'|'pls_integer';
POSITIVE:                     'POSITIVE'|'positive';
POSITIVEN:                    'POSITIVEN'|'positiven';
PRAGMA:                       'PRAGMA'|'pragma';
PRECEDING:                    'PRECEDING'|'preceding';
PRECISION:                    'PRECISION'|'precision';
PRESENT:                      'PRESENT'|'present';
PRIOR:                        'PRIOR'|'prior';
PROCEDURE:                    'PROCEDURE'|'procedure';
RAISE:                        'RAISE'|'raise';
RANGE:                        'RANGE'|'range';
RAW:                          'RAW'|'raw';
READ:                         'READ'|'read';
REAL:                         'REAL'|'real';
RECORD:                       'RECORD'|'record';
REF:                          'REF'|'ref';
REFERENCE:                    'REFERENCE'|'reference';
REFERENCING:                  'REFERENCING'|'referencing';
REJECT:                       'REJECT'|'reject';
RELIES_ON:                    'RELIES_ON'|'relies_on';
RENAME:                       'RENAME'|'rename';
REPLACE:                      'REPLACE'|'replace';
RESPECT:                      'RESPECT'|'respect';
RESTRICT_REFERENCES:          'RESTRICT_REFERENCES'|'restrict_references';
RESULT:                       'RESULT'|'result';
RESULT_CACHE:                 'RESULT_CACHE'|'result_cache';
RETURN:                       'RETURN'|'return';
RETURNING:                    'RETURNING'|'returning';
REUSE:                        'REUSE'|'reuse';
REVERSE:                      'REVERSE'|'reverse';
REVOKE:                       'REVOKE'|'revoke';
RIGHT:                        'RIGHT'|'right';
ROLLBACK:                     'ROLLBACK'|'rollback';
ROLLUP:                       'ROLLUP'|'rollup';
ROW:                          'ROW'|'row';
ROWID:                        'ROWID'|'rowid';
ROWS:                         'ROWS'|'rows';
RULES:                        'RULES'|'rules';
SAMPLE:                       'SAMPLE'|'sample';
SAVE:                         'SAVE'|'save';
SAVEPOINT:                    'SAVEPOINT'|'savepoint';
SCHEMA:                       'SCHEMA'|'schema';
SCHEMACHECK:                  'SCHEMACHECK'|'schemacheck';
SCN:                          'SCN'|'scn';
SEARCH:                       'SEARCH'|'search';
SECOND:                       'SECOND'|'second';
SEED:                         'SEED'|'seed';
SEGMENT:                      'SEGMENT'|'segment';
SELECT:                       'SELECT'|'select';
SELF:                         'SELF'|'self';
SEQUENCE:                     'SEQUENCE'|'sequence';
SEQUENTIAL:                   'SEQUENTIAL'|'sequential';
SERIALIZABLE:                 'SERIALIZABLE'|'serializable';
SERIALLY_REUSABLE:            'SERIALLY_REUSABLE'|'serially_reusable';
SERVERERROR:                  'SERVERERROR'|'servererror';
SESSIONTIMEZONE:              'SESSIONTIMEZONE'|'sessiontimezone';
SET:                          'SET'|'set';
SETS:                         'SETS'|'sets';
SETTINGS:                     'SETTINGS'|'settings';
SHARE:                        'SHARE'|'share';
SHOW:                         'SHOW'|'show';
SHUTDOWN:                     'SHUTDOWN'|'shutdown';
SIBLINGS:                     'SIBLINGS'|'siblings';
SIGNTYPE:                     'SIGNTYPE'|'signtype';
SIMPLE_INTEGER:               'SIMPLE_INTEGER'|'simple_integer';
SINGLE:                       'SINGLE'|'single';
SIZE:                         'SIZE'|'size';
SKIP_:                        'SKIP'|'skip';
SMALLINT:                     'SMALLINT'|'smallint';
SNAPSHOT:                     'SNAPSHOT'|'snapshot';
SOME:                         'SOME'|'some';
SPECIFICATION:                'SPECIFICATION'|'specification';
SQLDATA:                      'SQLDATA'|'sqldata';
SQLERROR:                     'SQLERROR'|'sqlerror';
STANDALONE:                   'STANDALONE'|'standalone';
START:                        'START'|'start';
STARTUP:                      'STARTUP'|'startup';
STATEMENT:                    'STATEMENT'|'statement';
STATEMENT_ID:                 'STATEMENT_ID'|'statement_id';
STATIC:                       'STATIC'|'static';
STATISTICS:                   'STATISTICS'|'statistics';
STRING:                       'STRING'|'string';
SUBMULTISET:                  'SUBMULTISET'|'submultiset';
SUBPARTITION:                 'SUBPARTITION'|'subpartition';
SUBSTITUTABLE:                'SUBSTITUTABLE'|'substitutable';
SUBTYPE:                      'SUBTYPE'|'subtype';
SUCCESS:                      'SUCCESS'|'success';
SUSPEND:                      'SUSPEND'|'suspend';
SYSDATE:                      'SYSDATE'|'sysdate';
TABLE:                        'TABLE'|'table';
THE:                          'THE'|'the';
THEN:                         'THEN'|'then'|'Then';
TIME:                         'TIME'|'time';
TIMESTAMP:                    'TIMESTAMP'|'timestamp';
TIMESTAMP_LTZ_UNCONSTRAINED:  'TIMESTAMP_LTZ_UNCONSTRAINED'|'timestamp_ltz_unconstrained';
TIMESTAMP_TZ_UNCONSTRAINED:   'TIMESTAMP_TZ_UNCONSTRAINED'|'timestamp_tz_unconstrained';
TIMESTAMP_UNCONSTRAINED:      'TIMESTAMP_UNCONSTRAINED'|'timestamp_unconstrained';
TIMEZONE_ABBR:                'TIMEZONE_ABBR'|'timezone_abbr';
TIMEZONE_HOUR:                'TIMEZONE_HOUR'|'timezone_hour';
TIMEZONE_MINUTE:              'TIMEZONE_MINUTE'|'timezone_minute';
TIMEZONE_REGION:              'TIMEZONE_REGION'|'timezone_region';
TO:                           'TO'|'to';
TRAILING:                     'TRAILING'|'trailing';
TRANSACTION:                  'TRANSACTION'|'transcation';
TRANSLATE:                    'TRANSLATE'|'translate';
TREAT:                        'TREAT'|'treat';
TRIGGER:                      'TRIGGER'|'trigger';
TRUE:                         'TRUE'|'true';
TRUNCATE:                     'TRUNCATE'|'truncate';
TYPE:                         'TYPE'|'type';
UNBOUNDED:                    'UNBOUNDED'|'unbounded';
UNDER:                        'UNDER'|'under';
UNION:                        'UNION'|'union';
UNIQUE:                       'UNIQUE'|'unique';
UNLIMITED:                    'UNLIMITED'|'unlimited';
UNPIVOT:                      'UNPIVOT'|'unpivot';
UNTIL:                        'UNTIL'|'until';
UPDATE:                       'UPDATE'|'update';
UPDATED:                      'UPDATED'|'updated';
UPSERT:                       'UPSERT'|'upsert';
UROWID:                       'UROWID'|'urowid';
USE:                          'USE'|'use';
USING:                        'USING'|'using';
VALIDATE:                     'VALIDATE'|'validate';
VALUE:                        'VALUE'|'value';
VALUES:                       'VALUES'|'values';
VARCHAR:                      'VARCHAR'|'varchar';
VARCHAR2:                     'VARCHAR2'|'varchar2';
VARIABLE:                     'VARIABLE'|'variable';
VARRAY:                       'VARRAY'|'varray';
VARYING:                      'VARYING'|'varying';
VERSION:                      'VERSION'|'version';
VERSIONS:                     'VERSIONS'|'versions';
WAIT:                         'WAIT'|'wait';
WARNING:                      'WARNING'|'warning';
WELLFORMED:                   'WELLFORMED'|'wellformed';
WHEN:                         'WHEN'|'when';
WHENEVER:                     'WHENEVER'|'whenever';
WHERE:                        'WHERE'|'where';
WHILE:                        'WHILE'|'while';
WITH:                         'WITH'|'with';
WITHIN:                       'WITHIN'|'within';
WORK:                         'WORK'|'work';
WRITE:                        'WRITE'|'write';
XML:                          'XML'|'xml';
XMLAGG:                       'XMLAGG'|'xmlagg';
XMLATTRIBUTES:                'XMLATTRIBUTES'|'xmlattributes';
XMLCAST:                      'XMLCAST'|'xmlcast';
XMLCOLATTVAL:                 'XMLCOLATTVAL'|'xmlcolattval';
XMLELEMENT:                   'XMLELEMENT'|'xmlelement';
XMLEXISTS:                    'XMLEXISTS'|'xmlexists';
XMLFOREST:                    'XMLFOREST'|'xmlforest';
XMLNAMESPACES:                'XMLNAMESPACES'|'xmlnamespaces';
XMLPARSE:                     'XMLPARSE'|'xmlparse';
XMLPI:                        'XMLPI'|'xmlpi';
XMLQUERY:                     'XMLQUERY'|'xmlquery';
XMLROOT:                      'XMLROOT'|'xmlroot';
XMLSERIALIZE:                 'XMLSERIALIZE'|'xmlserialize';
XMLTABLE:                     'XMLTABLE'|'xmltable';
YEAR:                         'YEAR'|'year';
YES:                          'YES'|'yes';
YMINTERVAL_UNCONSTRAINED:     'YMINTERVAL_UNCONSTRAINED'|'yminterval_unconstrained';
ZONE:                         'ZONE'|'zone';
                                                              
PREDICTION:                   'PREDICTION'|'prediction';                     
PREDICTION_BOUNDS:            'PREDICTION_BOUNDS'|'prediction_bounds';
PREDICTION_COST:              'PREDICTION_COST'|'prediction_cost';
PREDICTION_DETAILS:           'PREDICTION_DETAILS'|'prediction_details';
PREDICTION_PROBABILITY:       'PREDICTION_PROBABILITY'|'prediction_probability';
PREDICTION_SET:               'PREDICTION_SET'|'prediction_set';
                                                                    
CUME_DIST:                    'CUME_DIST'|'cume_dist';
DENSE_RANK:                   'DENSE_RANK'|'dense_rank';
LISTAGG:                      'LISTAGG'|'listagg';
PERCENT_RANK:                 'PERCENT_RANK'|'percent_rank';
PERCENTILE_CONT:              'PERCENTILE_CONT'|'percentile_cont';
PERCENTILE_DISC:              'PERCENTILE_DISC'|'percentile_disc';
RANK:                         'RANK'|'rank';
                                                                    
AVG:                          'AVG'|'avg';
CORR:                         'CORR'|'corr';
COVAR_:                       'COVAR_'|'covar_';
DECODE:                       'DECODE'|'decode';
LAG:                          'LAG'|'lag';
LEAD:                         'LEAD'|'lead';
MAX:                          'MAX'|'max';
MEDIAN:                       'MEDIAN'|'median';
MIN:                          'MIN'|'min';
NTILE:                        'NTILE'|'ntile';
NVL:                          'NVL'|'nvl';
RATIO_TO_REPORT:              'RATIO_TO_REPORT'|'ratio_to_report';
REGR_:                        'REGR_'|'regr_';
ROUND:                        'ROUND'|'round';
ROW_NUMBER:                   'ROW_NUMBER'|'row_number';
SUBSTR:                       'SUBSTR'|'substr';
TO_CHAR:                      'TO_CHAR'|'to_char';
TRIM:                         'TRIM'|'trim';
SUM:                          'SUM'|'sum';
STDDEV:                       'STDDEV'|'stddev';
VAR_:                         'VAR_'|'var_';
VARIANCE:                     'VARIANCE'|'variance';
                                                                    
ADD_MONTHS:                   'ADD_MONTHS'|'add_months';
LAST_DAY:                      'LAST_DAY'|'last_day';
TO_DATE:                       'TO_DATE'|'to_date';
MOD:                           'MOD'|'mod';
TRUNC:                         'TRUNC'|'trunc';

// Rule #358 <NATIONAL_CHAR_STRING_LIT> - subtoken typecast in <REGULAR_ID>, it also incorporates <character_representation>
//  Lowercase 'n' is a usual addition to the standard
NATIONAL_CHAR_STRING_LIT: 'N' '\'' (~('\'' | '\r' | '\n' ) | '\'' '\'' | NEWLINE)* '\'';

//  Rule #040 <BIT_STRING_LIT> - subtoken typecast in <REGULAR_ID>
//  Lowercase 'b' is a usual addition to the standard
BIT_STRING_LIT: 'B' ('\'' [01]* '\'')+;

//  Rule #284 <HEX_STRING_LIT> - subtoken typecast in <REGULAR_ID>
//  Lowercase 'x' is a usual addition to the standard
HEX_STRING_LIT: 'X' ('\'' [A-F0-9]* '\'')+;
DOUBLE_PERIOD: '..';
PERIOD:        '.';

//{ Rule #238 <EXACT_NUM_LIT>
//  This rule is a bit tricky - it resolves the ambiguity with <PERIOD> 
//  It also incorporates <mantisa> and <exponent> for the <APPROXIMATE_NUM_LIT>
//  Rule #501 <signed_integer> was incorporated directly in the token <APPROXIMATE_NUM_LIT>
//  See also the rule #617 <unsigned_num_lit>
/*
    : (
            UNSIGNED_INTEGER
            ( '.' UNSIGNED_INTEGER
            | {$type = UNSIGNED_INTEGER;}
            ) ( E ('+' | '-')? UNSIGNED_INTEGER {$type = APPROXIMATE_NUM_LIT;} )?
    | '.' UNSIGNED_INTEGER ( E ('+' | '-')? UNSIGNED_INTEGER {$type = APPROXIMATE_NUM_LIT;} )?
    )
    (D | F)?
    ;*/

UNSIGNED_INTEGER: UNSIGNED_INTEGER_FRAGMENT;
APPROXIMATE_NUM_LIT: FLOAT_FRAGMENT ('E' ('+'|'-')? (FLOAT_FRAGMENT | UNSIGNED_INTEGER_FRAGMENT))? ('D' | 'F')?;

// Rule #--- <CHAR_STRING> is a base for Rule #065 <char_string_lit> , it incorporates <character_representation>
// and a superfluous subtoken typecasting of the "QUOTE"
CHAR_STRING: '\'' (~('\'' | '\r' | '\n') | '\'' '\'' | NEWLINE)* '\'';

// Perl-style quoted string, see Oracle SQL reference, chapter String Literals
CHAR_STRING_PERL    : 'Q' ( QS_ANGLE | QS_BRACE | QS_BRACK | QS_PAREN) -> type(CHAR_STRING);
fragment QUOTE      : '\'' ;
fragment QS_ANGLE   : QUOTE '<' .*? '>' QUOTE ;
fragment QS_BRACE   : QUOTE '{' .*? '}' QUOTE ;
fragment QS_BRACK   : QUOTE '[' .*? ']' QUOTE ;
fragment QS_PAREN   : QUOTE '(' .*? ')' QUOTE ;
fragment QS_OTHER_CH: ~('<' | '{' | '[' | '(' | ' ' | '\t' | '\n' | '\r');

// Rule #163 <DELIMITED_ID>
DELIMITED_ID: '"' (~('"' | '\r' | '\n') | '"' '"')+ '"' ;

// Rule #546 <SQL_SPECIAL_CHAR> was split into single rules
PERCENT: '%';
AMPERSAND: '&';
LEFT_PAREN: '(';
RIGHT_PAREN: ')';
DOUBLE_ASTERISK: '**';
ASTERISK: '*';
PLUS_SIGN: '+';
MINUS_SIGN: '-';
COMMA: ',';
SOLIDUS: '/';
AT_SIGN: '@';
ASSIGN_OP: ':=';
    
// See OCI reference for more information about this
BINDVAR
    : ':' SIMPLE_LETTER  (SIMPLE_LETTER | [0-9] | '_')*
    | ':' DELIMITED_ID  // not used in SQL but spotted in v$sqltext when using cursor_sharing
    | ':' UNSIGNED_INTEGER
    | QUESTION_MARK // not in SQL, not in Oracle, not in OCI, use this for JDBC
    ;

COLON: ':';
SEMICOLON: ';';
LESS_THAN_OR_EQUALS_OP: '<=';
LESS_THAN_OP: '<';
GREATER_THAN_OR_EQUALS_OP: '>=';
NOT_EQUAL_OP: '!='| '<>'| '^='| '~=';
CARRET_OPERATOR_PART: '^';
TILDE_OPERATOR_PART: '~';
EXCLAMATION_OPERATOR_PART: '!';
GREATER_THAN_OP: '>';

fragment
QUESTION_MARK: '?';

// protected UNDERSCORE : '_' SEPARATOR ; // subtoken typecast within <INTRODUCER>
CONCATENATION_OP: '||';
VERTICAL_BAR: '|';
EQUALS_OP: '=';

// Rule #532 <SQL_EMBDD_LANGUAGE_CHAR> was split into single rules:
LEFT_BRACKET: '[';
RIGHT_BRACKET: ']';

//{ Rule #319 <INTRODUCER>
INTRODUCER
    : '_' //(SEPARATOR {$type = UNDERSCORE;})?
    ;

//{ Rule #479 <SEPARATOR>
//  It was originally a protected rule set to be filtered out but the <COMMENT> and <'-'> clashed. 
/*SEPARATOR
    : '-' -> type('-')
    | COMMENT -> channel(HIDDEN)
    | (SPACE | NEWLINE)+ -> channel(HIDDEN)
    ;*/
//}

SPACES: [ \t\r\n]+ -> skip;
    
//{ Rule #504 <SIMPLE_LETTER> - simple_latin _letter was generalised into SIMPLE_LETTER
//  Unicode is yet to be implemented - see NSF0
fragment
SIMPLE_LETTER
    : [a-zA-Z]
    ;
//}

//  Rule #176 <DIGIT> was incorporated by <UNSIGNED_INTEGER> 
//{ Rule #615 <UNSIGNED_INTEGER> - subtoken typecast in <EXACT_NUM_LIT> 
fragment
UNSIGNED_INTEGER_FRAGMENT: [0-9]+ ;

fragment
FLOAT_FRAGMENT
    : UNSIGNED_INTEGER* '.'? UNSIGNED_INTEGER+
    ;

MINUS_INTEGER: MINUS_INTEGER_FRAGMENT;
fragment
MINUS_INTEGER_FRAGMENT:  '-' UNSIGNED_INTEGER*;


//{ Rule #097 <COMMENT>
SINGLE_LINE_COMMENT: '--' ~('\r' | '\n')* (NEWLINE | EOF)   -> channel(HIDDEN);
MULTI_LINE_COMMENT: '/*' .*? '*/'                           -> channel(HIDDEN);

// SQL*Plus prompt
// TODO should be grammar rule, but tricky to implement
PROMPT
    : 'prompt' SPACE ( ~('\r' | '\n') )* (NEWLINE|EOF)
    ;

//{ Rule #360 <NEWLINE>
fragment
NEWLINE: '\r'? '\n';
    
fragment
SPACE: [ \t];

//{ Rule #442 <REGULAR_ID> additionally encapsulates a few STRING_LITs.
//  Within testLiterals all reserved and non-reserved words are being resolved

REGULAR_ID: SIMPLE_LETTER (SIMPLE_LETTER | '$' | '_' | '#' | [0-9])*;
ZV: '@!' -> channel(HIDDEN);