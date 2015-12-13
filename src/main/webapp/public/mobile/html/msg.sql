
CREATE TABLE if not exists "Contact" (
"buddyId"  INTEGER NOT NULL,
"account"  TEXT,
"name"  TEXT,
"tel"  TEXT,
"state"  INTEGER,
"addtime"  datetime,
"lastReadTime"  datetime,
"active"  INTEGER
);

CREATE TABLE if not exists "SingleChatMsg" (
"myId"  INTEGER NOT NULL,
"buddyId"  INTEGER NOT NULL,
"msg"  TEXT,
"sendTime"  datetime
);

