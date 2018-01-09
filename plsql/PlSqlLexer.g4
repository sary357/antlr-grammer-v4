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
ADD:                          'ADD' |'add'|'Add';
AFTER:                        'AFTER' |'after'|'After';
AGENT:                        'AGENT' |'agent'|'Agent';
AGGREGATE:                    'AGGREGATE' |'aggregate'|'Aggregate';
ALL:                          'ALL' |'all'|'All';
ALTER:                        'ALTER' |'alter'|'Alter';
ANALYZE:                      'ANALYZE' |'analyze'|'Analyze';
AND:                          'AND' |'and'|'And';
ANY:                          'ANY' |'any'|'Any';
ARRAY:                        'ARRAY' |'array'|'Array';
AS:                           'AS' |'as'|'As';
ASC:                          'ASC' |'asc'|'Asc';
ASSOCIATE:                    'ASSOCIATE' |'associate'|'Associate';
AT:                           'AT'|'at'|'At';
ATTRIBUTE:                    'ATTRIBUTE' |'attribute'|'Attribute';
AUDIT:                        'AUDIT' |'audit'|'Audit';
AUTHID:                       'AUTHID' |'authid'|'Authid';
AUTO:                         'AUTO' |'auto'|'Auto';
AUTOMATIC:                    'AUTOMATIC' |'automatic'|'Automatic';
AUTONOMOUS_TRANSACTION:       'AUTONOMOUS_TRANSACTION' |'autonomous_transaction'|'Autonomous_transaction';
BATCH:                        'BATCH'|'batch'|'Batch';
BEFORE:                       'BEFORE'|'before'|'Before';
BEGIN:                        'BEGIN'|'begin'|'Begin';
BETWEEN:                      'BETWEEN'|'between'|'Between';
BFILE:                        'BFILE'|'bfile'|'Bfile';
BINARY_DOUBLE:                'BINARY_DOUBLE'|'binary_double'|'Binary_double';
BINARY_FLOAT:                 'BINARY_FLOAT'|'binary_float'|'Binary_float';
BINARY_INTEGER:               'BINARY_INTEGER'|'binary_integer'|'Binary_integer';
BLOB:                         'BLOB'|'blob'|'Blob';
BLOCK:                        'BLOCK'|'block'|'Block';
BODY:                         'BODY'|'body'|'Body';
BOOLEAN:                      'BOOLEAN'|'boolean'|'Boolean';
BOTH:                         'BOTH'|'both'|'Both';
BREADTH:                      'BREADTH'|'breadth'|'Breadth';
BULK:                         'BULK'|'bulk'|'Bulk';
BY:                           'BY'|'by'|'By';
BYTE:                         'BYTE'|'byte'|'Byte';
C_LETTER:                     'C'|'c';
CACHE:                        'CACHE'|'cache'|'Cache';
CALL:                         'CALL'|'call'|'Call';
CANONICAL:                    'CANONICAL'|'canonical'|'Canonical';
CASCADE:                      'CASCADE'|'cascade'|'Cascade';
CASE:                         'CASE'|'case'|'Case';
CAST:                         'CAST'|'cast'|'Cast';
CHAR:                         'CHAR'|'char'|'Char';
CHAR_CS:                      'CHAR_CS'|'char_cs'|'Char_cs';
CHARACTER:                    'CHARACTER'|'character'|'Character';
CHECK:                        'CHECK'|'check'|'Check';
CHR:                          'CHR'|'chr'|'Chr';
CLOB:                         'CLOB'|'clob'|'Clob';
CLOSE:                        'CLOSE'|'close'|'Close';
CLUSTER:                      'CLUSTER'|'cluster'|'Cluster';
COALESCE:                     'COALESCE'|'coalesce'|'Coalesce';
COLLECT:                      'COLLECT'|'collect'|'Collect';
COLUMNS:                      'COLUMNS'|'columns'|'Columns';
COMMENT:                      'COMMENT'|'comment'|'Comment';
COMMIT:                       'COMMIT'|'commit'|'Commit';
COMMITTED:                    'COMMITTED'|'committed'|'Committed';
COMPATIBILITY:                'COMPATIBILITY'|'compatibility'|'Compatibility';
COMPILE:                      'COMPILE'|'compile'|'Compile';
COMPOUND:                     'COMPOUND'|'compound'|'Compound';
CONNECT:                      'CONNECT'|'connect'|'Connect';
CONNECT_BY_ROOT:              'CONNECT_BY_ROOT'|'connect_by_root'|'Connect_by_root';
CONSTANT:                     'CONSTANT'|'constant'|'Constant';
CONSTRAINT:                   'CONSTRAINT'|'constraint'|'Constraint';
CONSTRAINTS:                  'CONSTRAINTS'|'constraints'|'Constraints';
CONSTRUCTOR:                  'CONSTRUCTOR'|'constructor'|'Constructor';
CONTENT:                      'CONTENT'|'content'|'Content';
CONTEXT:                      'CONTEXT'|'context'|'Context';
CONTINUE:                     'CONTINUE'|'continue'|'Continue';
CONVERT:                      'CONVERT'|'convert'|'Convert';
CORRUPT_XID:                  'CORRUPT_XID'|'corrupt_xid'|'Corrupt_xid';
CORRUPT_XID_ALL:              'CORRUPT_XID_ALL'|'corrupt_xid_all'|'Corrupt_xid_all';
COST:                         'COST'|'cost'|'Cost';
COUNT:                        'COUNT'|'count'|'Count';
CREATE:                       'CREATE'|'create'|'Create';
CROSS:                        'CROSS'|'cross'|'Cross';
CUBE:                         'CUBE'|'cube'|'Cube';
CURRENT:                      'CURRENT'|'current'|'Current';
CURRENT_USER:                 'CURRENT_USER'|'current_user'|'Current_user';
CURSOR:                       'CURSOR'|'cursor'|'Cursor';
CUSTOMDATUM:                  'CUSTOMDATUM'|'customdatum'|'Customdatum';
CYCLE:                        'CYCLE'|'cycle'|'Cycle';
DATA:                         'DATA'|'data'|'Data';
DATABASE:                     'DATABASE'|'database'|'Database';
DATE:                         'DATE'|'date'|'Date';
DAY:                          'DAY'|'day'|'Day';
DB_ROLE_CHANGE:               'DB_ROLE_CHANGE'|'db_role_change'|'Db_role_change';
DBTIMEZONE:                   'DBTIMEZONE'|'dbtimezone'|'Dbtimezone';
DDL:                          'DDL'|'ddl'|'Ddl';
DEBUG:                        'DEBUG'|'debug'|'Debug';
DEC:                          'DEC'|'dec'|'Dec';
DECIMAL:                      'DECIMAL'|'decimal'|'Decimal';
DECLARE:                      'DECLARE'|'declare'|'Declare';
DECOMPOSE:                    'DECOMPOSE'|'decompose'|'Decompose';
DECREMENT:                    'DECREMENT'|'decrement'|'Decrement';
DEFAULT:                      'DEFAULT'|'default'|'Default';
DEFAULTS:                     'DEFAULTS'|'defaults'|'Defaults';
DEFERRED:                     'DEFERRED'|'deferred'|'Deferred';
DEFINER:                      'DEFINER'|'definer'|'Definer';
DELETE:                       'DELETE'|'delete'|'Delete';
DEPTH:                        'DEPTH'|'depth'|'Depth';
DESC:                         'DESC'|'desc'|'Desc';
DETERMINISTIC:                'DETERMINISTIC'|'deterministic'|'Deterministic';
DIMENSION:                    'DIMENSION'|'dimension'|'Dimension';
DISABLE:                      'DISABLE'|'disable'|'Disable';
DISASSOCIATE:                 'DISASSOCIATE'|'disassociate'|'Disassociate';
DISTINCT:                     'DISTINCT'|'distinct'|'Distinct';
DOCUMENT:                     'DOCUMENT'|'document'|'Document';
DOUBLE:                       'DOUBLE'|'double'|'Double';
DROP:                         'DROP'|'drop'|'Drop';
DSINTERVAL_UNCONSTRAINED:     'DSINTERVAL_UNCONSTRAINED'|'dsinterval_unconstrained'|'Dsinterval_unconstrained';
EACH:                         'EACH'|'each'|'Each';
ELEMENT:                      'ELEMENT'|'element'|'Element';
ELSE:                         'ELSE'|'else'|'Else'|'ElSE';
ELSIF:                        'ELSIF'|'elsif'|'Elsif';
EMPTY:                        'EMPTY'|'empty'|'Empty';
ENABLE:                       'ENABLE'|'enable'|'Enable';
ENCODING:                     'ENCODING'|'encoding'|'Encoding';
END:                          'END'|'end'|'End';
ENTITYESCAPING:               'ENTITYESCAPING'|'entityescaping'|'Entityescaping';
ERR:                          'ERR'|'err'|'Err';
ERRORS:                       'ERRORS'|'errors'|'Errors';
ESCAPE:                       'ESCAPE'|'escape'|'Escape';
EVALNAME:                     'EVALNAME'|'evalname'|'Evalname';
EXCEPTION:                    'EXCEPTION'|'exception'|'Exception';
EXCEPTION_INIT:               'EXCEPTION_INIT'|'exception_init'|'Exception_init';
EXCEPTIONS:                   'EXCEPTIONS'|'exceptions'|'Exceptions';
EXCLUDE:                      'EXCLUDE'|'exclude'|'Exclude';
EXCLUSIVE:                    'EXCLUSIVE'|'exclusive'|'Exclusive';
EXECUTE:                      'EXECUTE'|'execute'|'Execute';
EXISTS:                       'EXISTS'|'exists'|'Exists';
EXIT:                         'EXIT'|'exit'|'Exit';
EXPLAIN:                      'EXPLAIN'|'explain'|'Explain';
EXTERNAL:                     'EXTERNAL'|'external'|'External';
EXTRACT:                      'EXTRACT'|'extract'|'Extract';
FAILURE:                      'FAILURE'|'failure'|'Failure';
FALSE:                        'FALSE'|'false'|'False';
FETCH:                        'FETCH'|'fetch'|'Fetch';
FINAL:                        'FINAL'|'final'|'Final';
FIRST:                        'FIRST'|'first'|'First';
FIRST_VALUE:                  'FIRST_VALUE'|'first_value'|'First_value';
FLOAT:                        'FLOAT'|'float'|'Float';
FOLLOWING:                    'FOLLOWING'|'following'|'Following';
FOLLOWS:                      'FOLLOWS'|'follows'|'Follows';
FOR:                          'FOR'|'for'|'For';
FORALL:                       'FORALL'|'forall'|'Forall';
FORCE:                        'FORCE'|'force'|'Force';
FROM:                         'FROM'|'from'|'From';
FULL:                         'FULL'|'full'|'Full';
FUNCTION:                     'FUNCTION'|'function'|'Function';
GOTO:                         'GOTO'|'goto'|'Goto';
GRANT:                        'GRANT'|'grant'|'Grant';
GROUP:                        'GROUP'|'group'|'Group';
GROUPING:                     'GROUPING'|'grouping'|'Grouping';
HASH:                         'HASH'|'hash'|'Hash';
HAVING:                       'HAVING'|'having'|'Having';
HIDE:                         'HIDE'|'hide'|'Hide';
HOUR:                         'HOUR'|'hour'|'Hour';
IF:                           'IF'|'if'|'If';
IGNORE:                       'IGNORE'|'ignore'|'Ignore';
IMMEDIATE:                    'IMMEDIATE'|'immediate'|'Immediate';
IN:                           'IN'|'in'|'In';
INCLUDE:                      'INCLUDE'|'include'|'Include';
INCLUDING:                    'INCLUDING'|'including'|'Including';
INCREMENT:                    'INCREMENT'|'increment'|'Increment';
INDENT:                       'INDENT'|'indent'|'Indent';
INDEX:                        'INDEX'|'index'|'Index';
INDEXED:                      'INDEXED'|'indexed'|'Indexed';
INDICATOR:                    'INDICATOR'|'indicator'|'Indicator';
INDICES:                      'INDICES'|'indices'|'Indices';
INFINITE:                     'INFINITE'|'infinite'|'Infinite';
INLINE:                       'INLINE'|'inline'|'Inline';
INNER:                        'INNER'|'inner'|'Inner';
INOUT:                        'INOUT'|'inout'|'Inout';
INSERT:                       'INSERT'|'insert'|'Insert';
INSTANTIABLE:                 'INSTANTIABLE'|'instantiable'|'Instantiable';
INSTEAD:                      'INSTEAD'|'instead'|'Instead';
INT:                          'INT'|'int'|'Int';
INTEGER:                      'INTEGER'|'integer'|'Integer';
INTERSECT:                    'INTERSECT'|'intersect'|'Intersect';
INTERVAL:                     'INTERVAL'|'interval'|'Interval';
INTO:                         'INTO'|'into'|'Into';
INVALIDATE:                   'INVALIDATE'|'invalidate'|'Invalidate';
IS:                           'IS'|'is'|'Is';
ISOLATION:                    'ISOLATION'|'isolation'|'Isolation';
ITERATE:                      'ITERATE'|'iterate'|'Iterate';
JAVA:                         'JAVA'|'java'|'Java';
JOIN:                         'JOIN'|'join'|'Join';
KEEP:                         'KEEP'|'keep'|'Keep';
LANGUAGE:                     'LANGUAGE'|'language'|'Language';
LAST:                         'LAST'|'last'|'Last';
LAST_VALUE:                   'LAST_VALUE'|'last_value'|'Last_value';
LEADING:                      'LEADING'|'leading'|'Leading';
LEFT:                         'LEFT'|'left'|'Left';
LEVEL:                        'LEVEL'|'level'|'Level';
LIBRARY:                      'LIBRARY'|'library'|'Library';
LIKE:                         'LIKE'|'like'|'Like';
LIKE2:                        'LIKE2'|'like2'|'Like2';
LIKE4:                        'LIKE4'|'like4'|'Like4';
LIKEC:                        'LIKEC'|'likec'|'Likec';
LIMIT:                        'LIMIT'|'limit'|'Limit';
LOCAL:                        'LOCAL'|'local'|'Local';
LOCK:                         'LOCK'|'lock'|'Lock';
LOCKED:                       'LOCKED'|'locked'|'Locked';
LOG:                          'LOG'|'log'|'Log';
LOGOFF:                       'LOGOFF'|'logoff'|'Logoff';
LOGON:                        'LOGON'|'logon'|'Logon';
LONG:                         'LONG'|'long'|'Long';
LOOP:                         'LOOP'|'loop'|'Loop';
MAIN:                         'MAIN'|'main'|'Main';
MAP:                          'MAP'|'map'|'Map';
MATCHED:                      'MATCHED'|'matched'|'Matched';
MAXVALUE:                     'MAXVALUE'|'maxvalue'|'Maxvalue';
MEASURES:                     'MEASURES'|'measures'|'Measures';
MEMBER:                       'MEMBER'|'member'|'Member';
MERGE:                        'MERGE'|'merge'|'Merge';
MINUS:                        'MINUS'|'minus'|'Minus';
MINUTE:                       'MINUTE'|'minute'|'Minute';
MINVALUE:                     'MINVALUE'|'minvalue'|'Minvalue';
MLSLABEL:                     'MLSLABEL'|'mlslabel'|'Mlslabel';
MODE:                         'MODE'|'mode'|'Mode';
MODEL:                        'MODEL'|'model'|'Model';
MODIFY:                       'MODIFY'|'modify'|'Modify';
MONTH:                        'MONTH'|'month'|'Month';
MULTISET:                     'MULTISET'|'multiset'|'Multiset';
NAME:                         'NAME'|'name'|'Name';
NAN:                          'NAN'|'nan'|'Nan';
NATURAL:                      'NATURAL'|'natural'|'Natural';
NATURALN:                     'NATURALN'|'naturaln'|'Naturaln';
NAV:                          'NAV'|'nav'|'Nav';
NCHAR:                        'NCHAR'|'nchar'|'Nchar';
NCHAR_CS:                     'NCHAR_CS'|'nchar_cs'|'Nchar_cs';
NCLOB:                        'NCLOB'|'nclob'|'Nclob';
NESTED:                       'NESTED'|'nested'|'Nested';
NEW:                          'NEW'|'new'|'New';
NO:                           'NO'|'no'|'No';
NOAUDIT:                      'NOAUDIT'|'noaudit'|'Noaudit';
NOCACHE:                      'NOCACHE'|'nocache'|'Nocache';
NOCOPY:                       'NOCOPY'|'nocopy'|'Nocopy';
NOCYCLE:                      'NOCYCLE'|'nocycle'|'Nocycle';
NOENTITYESCAPING:             'NOENTITYESCAPING'|'noentityescaping'|'Noentityescaping';
NOMAXVALUE:                   'NOMAXVALUE'|'nomaxvalue'|'Nomaxvalue';
NOMINVALUE:                   'NOMINVALUE'|'nominvalue'|'Nominvalue';
NONE:                         'NONE'|'none'|'None';
NOORDER:                      'NOORDER'|'noorder'|'Noorder';
NOSCHEMACHECK:                'NOSCHEMACHECK'|'noschemacheck'|'Noschemacheck';
NOT:                          'NOT'|'not'|'Not';
NOWAIT:                       'NOWAIT'|'nowait'|'Nowait';
NULL:                         'NULL'|'null'|'Null';
NULLS:                        'NULLS'|'nulls'|'Nulls';
NUMBER:                       'NUMBER'|'number'|'Number';
NUMERIC:                      'NUMERIC'|'numeric'|'Numeric';
NVARCHAR2:                    'NVARCHAR2'|'nvarchar2'|'Nvarchar2';
OBJECT:                       'OBJECT'|'object'|'Object';
OF:                           'OF'|'of'|'Of';
OFF:                          'OFF'|'off'|'Off';
OID:                          'OID'|'oid'|'Oid';
OLD:                          'OLD'|'old'|'Old';
ON:                           'ON'|'on'|'On';
ONLY:                         'ONLY'|'only'|'Only';
OPEN:                         'OPEN'|'open'|'Open';
OPTION:                       'OPTION'|'option'|'Option';
OR:                           'OR'|'or'|'Or';
ORADATA:                      'ORADATA'|'oradata'|'Oradata';
ORDER:                        'ORDER'|'order'|'Order';
ORDINALITY:                   'ORDINALITY'|'ordinality'|'Ordinality';
OSERROR:                      'OSERROR'|'oserror'|'Oserror';
OUT:                          'OUT'|'out'|'Out';
OUTER:                        'OUTER'|'outer'|'Outer';
OVER:                         'OVER'|'over'|'Over';
OVERRIDING:                   'OVERRIDING'|'overriding'|'Overriding';
PACKAGE:                      'PACKAGE'|'package'|'Package';
PARALLEL_ENABLE:              'PARALLEL_ENABLE'|'parallel_enable'|'Parallel_enable';
PARAMETERS:                   'PARAMETERS'|'parameters'|'Parameters';
PARENT:                       'PARENT'|'parent'|'Parent';
PARTITION:                    'PARTITION'|'partition'|'Partition';
PASSING:                      'PASSING'|'passing'|'Passing';
PATH:                         'PATH'|'path'|'Path';
PERCENT_ISOPEN:               '%ISOPEN'|'%isopen'|'isopen';
PERCENT_FOUND:                '%FOUND'|'%found'|'found';
PERCENT_NOTFOUND:             '%NOTFOUND'|'%notfound'|'notfound';
PERCENT_ROWCOUNT:             '%ROWCOUNT'|'%rowcount'|'rowcount';
PERCENT_ROWTYPE:              '%ROWTYPE'|'%rowtype'|'rowtype';
PERCENT_TYPE:                 '%TYPE'|'%type'|'type';
PIPELINED:                    'PIPELINED'|'pipelined'|'Pipelined';
PIVOT:                        'PIVOT'|'pivot'|'Pivot';
PLAN:                         'PLAN'|'plan'|'Plan';
PLS_INTEGER:                  'PLS_INTEGER'|'pls_integer'|'Pls_integer';
POSITIVE:                     'POSITIVE'|'positive'|'Positive';
POSITIVEN:                    'POSITIVEN'|'positiven'|'Positiven';
PRAGMA:                       'PRAGMA'|'pragma'|'Pragma';
PRECEDING:                    'PRECEDING'|'preceding'|'Preceding';
PRECISION:                    'PRECISION'|'precision'|'Precision';
PRESENT:                      'PRESENT'|'present'|'Present';
PRIOR:                        'PRIOR'|'prior'|'Prior';
PROCEDURE:                    'PROCEDURE'|'procedure'|'Procedure';
RAISE:                        'RAISE'|'raise'|'Raise';
RANGE:                        'RANGE'|'range'|'Range';
RAW:                          'RAW'|'raw'|'Raw';
READ:                         'READ'|'read'|'Read';
REAL:                         'REAL'|'real'|'Real';
RECORD:                       'RECORD'|'record'|'Record';
REF:                          'REF'|'ref'|'Ref';
REFERENCE:                    'REFERENCE'|'reference'|'Reference';
REFERENCING:                  'REFERENCING'|'referencing'|'Referencing';
REJECT:                       'REJECT'|'reject'|'Reject';
RELIES_ON:                    'RELIES_ON'|'relies_on'|'Relies_on';
RENAME:                       'RENAME'|'rename'|'Rename';
REPLACE:                      'REPLACE'|'replace'|'Replace';
RESPECT:                      'RESPECT'|'respect'|'Respect';
RESTRICT_REFERENCES:          'RESTRICT_REFERENCES'|'restrict_references'|'Restrict_references';
RESULT:                       'RESULT'|'result'|'Result';
RESULT_CACHE:                 'RESULT_CACHE'|'result_cache'|'Result_cache';
RETURN:                       'RETURN'|'return'|'Return';
RETURNING:                    'RETURNING'|'returning'|'Returning';
REUSE:                        'REUSE'|'reuse'|'Reuse';
REVERSE:                      'REVERSE'|'reverse'|'Reverse';
REVOKE:                       'REVOKE'|'revoke'|'Revoke';
RIGHT:                        'RIGHT'|'right'|'Right';
ROLLBACK:                     'ROLLBACK'|'rollback'|'Rollback';
ROLLUP:                       'ROLLUP'|'rollup'|'Rollup';
ROW:                          'ROW'|'row'|'Row';
ROWID:                        'ROWID'|'rowid'|'Rowid';
ROWS:                         'ROWS'|'rows'|'Rows';
RULES:                        'RULES'|'rules'|'Rules';
SAMPLE:                       'SAMPLE'|'sample'|'Sample';
SAVE:                         'SAVE'|'save'|'Save';
SAVEPOINT:                    'SAVEPOINT'|'savepoint'|'Savepoint';
SCHEMA:                       'SCHEMA'|'schema'|'Schema';
SCHEMACHECK:                  'SCHEMACHECK'|'schemacheck'|'Schemacheck';
SCN:                          'SCN'|'scn'|'Scn';
SEARCH:                       'SEARCH'|'search'|'Search';
SECOND:                       'SECOND'|'second'|'Second';
SEED:                         'SEED'|'seed'|'Seed';
SEGMENT:                      'SEGMENT'|'segment'|'Segment';
SELECT:                       'SELECT'|'select'|'Select';
SELF:                         'SELF'|'self'|'Self';
SEQUENCE:                     'SEQUENCE'|'sequence'|'Sequence';
SEQUENTIAL:                   'SEQUENTIAL'|'sequential'|'Sequential';
SERIALIZABLE:                 'SERIALIZABLE'|'serializable'|'Serializable';
SERIALLY_REUSABLE:            'SERIALLY_REUSABLE'|'serially_reusable'|'Serially_reusable';
SERVERERROR:                  'SERVERERROR'|'servererror'|'Servererror';
SESSIONTIMEZONE:              'SESSIONTIMEZONE'|'sessiontimezone'|'Sessiontimezone';
SET:                          'SET'|'set'|'Set';
SETS:                         'SETS'|'sets'|'Sets';
SETTINGS:                     'SETTINGS'|'settings'|'Settings';
SHARE:                        'SHARE'|'share'|'Share';
SHOW:                         'SHOW'|'show'|'Show';
SHUTDOWN:                     'SHUTDOWN'|'shutdown'|'Shutdown';
SIBLINGS:                     'SIBLINGS'|'siblings'|'Siblings';
SIGNTYPE:                     'SIGNTYPE'|'signtype'|'Signtype';
SIMPLE_INTEGER:               'SIMPLE_INTEGER'|'simple_integer'|'Simple_integer';
SINGLE:                       'SINGLE'|'single'|'Single';
SIZE:                         'SIZE'|'size'|'Size';
SKIP_:                        'SKIP'|'skip'|'Skip';
SMALLINT:                     'SMALLINT'|'smallint'|'Smallint';
SNAPSHOT:                     'SNAPSHOT'|'snapshot'|'Snapshot';
SOME:                         'SOME'|'some'|'Some';
SPECIFICATION:                'SPECIFICATION'|'specification'|'Specification';
SQLDATA:                      'SQLDATA'|'sqldata'|'Sqldata';
SQLERROR:                     'SQLERROR'|'sqlerror'|'Sqlerror';
STANDALONE:                   'STANDALONE'|'standalone'|'Standalone';
START:                        'START'|'start'|'Start';
STARTUP:                      'STARTUP'|'startup'|'Startup';
STATEMENT:                    'STATEMENT'|'statement'|'Statement';
STATEMENT_ID:                 'STATEMENT_ID'|'statement_id'|'Statement_id';
STATIC:                       'STATIC'|'static'|'Static';
STATISTICS:                   'STATISTICS'|'statistics'|'Statistics';
STRING:                       'STRING'|'string'|'String';
SUBMULTISET:                  'SUBMULTISET'|'submultiset'|'Submultiset';
SUBPARTITION:                 'SUBPARTITION'|'subpartition'|'Subpartition';
SUBSTITUTABLE:                'SUBSTITUTABLE'|'substitutable'|'Substitutable';
SUBTYPE:                      'SUBTYPE'|'subtype'|'Subtype';
SUCCESS:                      'SUCCESS'|'success'|'Success';
SUSPEND:                      'SUSPEND'|'suspend'|'Suspend';
SYSDATE:                      'SYSDATE'|'sysdate'|'Sysdate';
TABLE:                        'TABLE'|'table'|'Table';
THE:                          'THE'|'the'|'The';
THEN:                         'THEN'|'then'|'Then';
TIME:                         'TIME'|'time'|'Time';
TIMESTAMP:                    'TIMESTAMP'|'timestamp'|'Timestamp';
TIMESTAMP_LTZ_UNCONSTRAINED:  'TIMESTAMP_LTZ_UNCONSTRAINED'|'timestamp_ltz_unconstrained'|'Timestamp_ltz_unconstrained';
TIMESTAMP_TZ_UNCONSTRAINED:   'TIMESTAMP_TZ_UNCONSTRAINED'|'timestamp_tz_unconstrained'|'Timestamp_tz_unconstrained';
TIMESTAMP_UNCONSTRAINED:      'TIMESTAMP_UNCONSTRAINED'|'timestamp_unconstrained'|'Timestamp_unconstrained';
TIMEZONE_ABBR:                'TIMEZONE_ABBR'|'timezone_abbr'|'Timezone_abbr';
TIMEZONE_HOUR:                'TIMEZONE_HOUR'|'timezone_hour'|'Timezone_hour';
TIMEZONE_MINUTE:              'TIMEZONE_MINUTE'|'timezone_minute'|'Timezone_minute';
TIMEZONE_REGION:              'TIMEZONE_REGION'|'timezone_region'|'Timezone_region';
TO:                           'TO'|'to'|'To';
TRAILING:                     'TRAILING'|'trailing'|'Trailing';
TRANSACTION:                  'TRANSACTION'|'transcation'|'Transcation';
TRANSLATE:                    'TRANSLATE'|'translate'|'Translate';
TREAT:                        'TREAT'|'treat'|'Treat';
TRIGGER:                      'TRIGGER'|'trigger'|'Trigger';
TRUE:                         'TRUE'|'true'|'True';
TRUNCATE:                     'TRUNCATE'|'truncate'|'Truncate';
TYPE:                         'TYPE'|'type'|'Type';
UNBOUNDED:                    'UNBOUNDED'|'unbounded'|'Unbounded';
UNDER:                        'UNDER'|'under'|'Under';
UNION:                        'UNION'|'union'|'Union';
UNIQUE:                       'UNIQUE'|'unique'|'Unique';
UNLIMITED:                    'UNLIMITED'|'unlimited'|'Unlimited';
UNPIVOT:                      'UNPIVOT'|'unpivot'|'Unpivot';
UNTIL:                        'UNTIL'|'until'|'Until';
UPDATE:                       'UPDATE'|'update'|'Update';
UPDATED:                      'UPDATED'|'updated'|'Updated';
UPSERT:                       'UPSERT'|'upsert'|'Upsert';
UROWID:                       'UROWID'|'urowid'|'Urowid';
USE:                          'USE'|'use'|'Use';
USING:                        'USING'|'using'|'Using';
VALIDATE:                     'VALIDATE'|'validate'|'Validate';
VALUE:                        'VALUE'|'value'|'Value';
VALUES:                       'VALUES'|'values'|'Values';
VARCHAR:                      'VARCHAR'|'varchar'|'Varchar';
VARCHAR2:                     'VARCHAR2'|'varchar2'|'Varchar2';
VARIABLE:                     'VARIABLE'|'variable'|'Variable';
VARRAY:                       'VARRAY'|'varray'|'Varray';
VARYING:                      'VARYING'|'varying'|'Varying';
VERSION:                      'VERSION'|'version'|'Version';
VERSIONS:                     'VERSIONS'|'versions'|'Versions';
WAIT:                         'WAIT'|'wait'|'Wait';
WARNING:                      'WARNING'|'warning'|'Warning';
WELLFORMED:                   'WELLFORMED'|'wellformed'|'Wellformed';
WHEN:                         'WHEN'|'when'|'When';
WHENEVER:                     'WHENEVER'|'whenever'|'Whenever';
WHERE:                        'WHERE'|'where'|'Where';
WHILE:                        'WHILE'|'while'|'While';
WITH:                         'WITH'|'with'|'With';
WITHIN:                       'WITHIN'|'within'|'Within';
WORK:                         'WORK'|'work'|'Work';
WRITE:                        'WRITE'|'write'|'Write';
XML:                          'XML'|'xml'|'Xml';
XMLAGG:                       'XMLAGG'|'xmlagg'|'Xmlagg';
XMLATTRIBUTES:                'XMLATTRIBUTES'|'xmlattributes'|'Xmlattributes';
XMLCAST:                      'XMLCAST'|'xmlcast'|'Xmlcast';
XMLCOLATTVAL:                 'XMLCOLATTVAL'|'xmlcolattval'|'Xmlcolattval';
XMLELEMENT:                   'XMLELEMENT'|'xmlelement'|'Xmlelement';
XMLEXISTS:                    'XMLEXISTS'|'xmlexists'|'Xmlexists';
XMLFOREST:                    'XMLFOREST'|'xmlforest'|'Xmlforest';
XMLNAMESPACES:                'XMLNAMESPACES'|'xmlnamespaces'|'Xmlnamespaces';
XMLPARSE:                     'XMLPARSE'|'xmlparse'|'Xmlparse';
XMLPI:                        'XMLPI'|'xmlpi'|'Xmlpi';
XMLQUERY:                     'XMLQUERY'|'xmlquery'|'Xmlquery';
XMLROOT:                      'XMLROOT'|'xmlroot'|'Xmlroot';
XMLSERIALIZE:                 'XMLSERIALIZE'|'xmlserialize'|'Xmlserialize';
XMLTABLE:                     'XMLTABLE'|'xmltable'|'Xmltable';
YEAR:                         'YEAR'|'year'|'Year';
YES:                          'YES'|'yes'|'Yes';
YMINTERVAL_UNCONSTRAINED:     'YMINTERVAL_UNCONSTRAINED'|'yminterval_unconstrained'|'Yminterval_unconstrained';
ZONE:                         'ZONE'|'zone'|'Zone';
                                                              
PREDICTION:                   'PREDICTION'|'prediction'|'Prediction';
PREDICTION_BOUNDS:            'PREDICTION_BOUNDS'|'prediction_bounds'|'Prediction_bounds';
PREDICTION_COST:              'PREDICTION_COST'|'prediction_cost'|'Prediction_cost';
PREDICTION_DETAILS:           'PREDICTION_DETAILS'|'prediction_details'|'Prediction_details';
PREDICTION_PROBABILITY:       'PREDICTION_PROBABILITY'|'prediction_probability'|'Prediction_probability';
PREDICTION_SET:               'PREDICTION_SET'|'prediction_set'|'Prediction_set';
                                                                    
CUME_DIST:                    'CUME_DIST'|'cume_dist'|'Cume_dist';
DENSE_RANK:                   'DENSE_RANK'|'dense_rank'|'Dense_rank';
LISTAGG:                      'LISTAGG'|'listagg'|'Listagg';
PERCENT_RANK:                 'PERCENT_RANK'|'percent_rank'|'Percent_rank';
PERCENTILE_CONT:              'PERCENTILE_CONT'|'percentile_cont'|'Percentile_cont';
PERCENTILE_DISC:              'PERCENTILE_DISC'|'percentile_disc'|'Percentile_disc';
RANK:                         'RANK'|'rank'|'Rank';
                                                                    
AVG:                          'AVG'|'avg'|'Avg';
CORR:                         'CORR'|'corr'|'Corr';
COVAR_:                       'COVAR_'|'covar_'|'Covar_';
DECODE:                       'DECODE'|'decode'|'Decode';
LAG:                          'LAG'|'lag'|'Lag';
LEAD:                         'LEAD'|'lead'|'Lead';
MAX:                          'MAX'|'max'|'Max';
MEDIAN:                       'MEDIAN'|'median'|'Median';
MIN:                          'MIN'|'min'|'Min';
NTILE:                        'NTILE'|'ntile'|'Ntile';
NVL:                          'NVL'|'nvl'|'Nvl';
RATIO_TO_REPORT:              'RATIO_TO_REPORT'|'ratio_to_report'|'Ratio_to_report';
REGR_:                        'REGR_'|'regr_'|'Regr_';
ROUND:                        'ROUND'|'round'|'Round';
ROW_NUMBER:                   'ROW_NUMBER'|'row_number'|'Row_number';
SUBSTR:                       'SUBSTR'|'substr'|'Substr';
TO_CHAR:                      'TO_CHAR'|'to_char'|'To_char';
TRIM:                         'TRIM'|'trim'|'Trim';
SUM:                          'SUM'|'sum'|'Sum';
STDDEV:                       'STDDEV'|'stddev'|'Stddev';
VAR_:                         'VAR_'|'var_'|'Var_';
VARIANCE:                     'VARIANCE'|'variance'|'Variance';
                                                                    
ADD_MONTHS:                   'ADD_MONTHS'|'add_months'|'Add_months';
LAST_DAY:                      'LAST_DAY'|'last_day'|'Last_day';
TO_DATE:                       'TO_DATE'|'to_date'|'To_date';
MOD:                           'MOD'|'mod'|'Mod';
TRUNC:                         'TRUNC'|'trunc'|'Trunc';

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