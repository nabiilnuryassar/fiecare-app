CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "email" varchar UNIQUE,
  "password" varchar,
  "timezone" varchar,
  "remember_token" varchar,
  "deleted_at" timestamp,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "profiles" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "nickname" varchar,
  "birthday" date,
  "preferences" json,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "devices" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "provider" varchar,
  "device_token" varchar,
  "platform" varchar,
  "last_seen_at" timestamp,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "reminder_rules" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "type" varchar,
  "schedule" json,
  "active" boolean,
  "priority" smallint,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "reminders" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "rule_id" bigint,
  "due_at" timestamp,
  "status" varchar,
  "completed_at" timestamp,
  "context" json,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "reminder_acknowledgements" (
  "id" bigserial PRIMARY KEY,
  "reminder_id" bigint,
  "user_id" bigint,
  "action" varchar,
  "created_at" timestamp
);

CREATE TABLE "mood_logs" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "mood" varchar,
  "logged_on" date,
  "note" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "message_templates" (
  "id" bigserial PRIMARY KEY,
  "channel" varchar,
  "audience" varchar,
  "activity" varchar,
  "locale" varchar,
  "content" text,
  "weight" smallint,
  "active" boolean,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "message_logs" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "source_type" varchar,
  "source_id" bigint,
  "template_id" bigint,
  "channel" varchar,
  "rendered" text,
  "sent_at" timestamp,
  "delivered_at" timestamp,
  "status" varchar,
  "meta" json,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "surprises" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "title" varchar,
  "body" text,
  "media_url" varchar,
  "trigger_type" varchar,
  "trigger_at" timestamp,
  "window" json,
  "active" boolean,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "surprise_dispatches" (
  "id" bigserial PRIMARY KEY,
  "surprise_id" bigint,
  "user_id" bigint,
  "dispatched_at" timestamp,
  "message_log_id" bigint,
  "status" varchar,
  "error" text,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "chats" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "last_message_at" timestamp,
  "unread_count" int,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "chat_messages" (
  "id" bigserial PRIMARY KEY,
  "chat_id" bigint,
  "sender" varchar,
  "body" text,
  "media_url" varchar,
  "sent_at" timestamp,
  "meta" json,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "assets" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint,
  "type" varchar,
  "key" varchar,
  "url" varchar,
  "width" int,
  "height" int,
  "meta" json,
  "created_at" timestamp,
  "updated_at" timestamp
);

COMMENT ON COLUMN "users"."timezone" IS 'Default Asia/Jakarta';

COMMENT ON COLUMN "devices"."provider" IS 'fcm | onesignal';

COMMENT ON COLUMN "devices"."platform" IS 'web | android | ios';

COMMENT ON COLUMN "reminder_rules"."user_id" IS 'null = default global';

COMMENT ON COLUMN "reminder_rules"."type" IS 'meal | workout | sleep';

COMMENT ON COLUMN "reminder_rules"."schedule" IS '{ "times": ["07:30","12:30","19:30"] }';

COMMENT ON COLUMN "reminders"."status" IS 'pending | sent | done | skipped';

COMMENT ON COLUMN "reminder_acknowledgements"."action" IS 'done | snooze | dismiss';

COMMENT ON COLUMN "mood_logs"."mood" IS 'happy | neutral | sad';

COMMENT ON COLUMN "message_templates"."channel" IS 'reminder | surprise | generic';

COMMENT ON COLUMN "message_templates"."audience" IS 'happy | neutral | sad | any';

COMMENT ON COLUMN "message_templates"."activity" IS 'meal | workout | sleep | none';

COMMENT ON COLUMN "message_templates"."content" IS 'gunakan {{name}}';

COMMENT ON COLUMN "message_logs"."source_type" IS 'reminder | surprise | system';

COMMENT ON COLUMN "message_logs"."channel" IS 'push | inapp | email';

COMMENT ON COLUMN "message_logs"."status" IS 'sent | failed';

COMMENT ON COLUMN "surprises"."trigger_type" IS 'fixed_date | random_window | birthday';

COMMENT ON COLUMN "surprises"."window" IS '{ "start":"YYYY-MM-DD","end":"YYYY-MM-DD","hour":"20:00" }';

COMMENT ON COLUMN "surprise_dispatches"."status" IS 'queued | sent | failed';

COMMENT ON COLUMN "chats"."user_id" IS 'target: Fierda';

COMMENT ON COLUMN "chat_messages"."sender" IS 'owner | fierda | bot';

COMMENT ON COLUMN "assets"."type" IS 'sprite | icon | image';

ALTER TABLE "profiles" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "devices" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reminder_rules" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reminders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reminders" ADD FOREIGN KEY ("rule_id") REFERENCES "reminder_rules" ("id");

ALTER TABLE "reminder_acknowledgements" ADD FOREIGN KEY ("reminder_id") REFERENCES "reminders" ("id");

ALTER TABLE "reminder_acknowledgements" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "mood_logs" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "message_logs" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "message_logs" ADD FOREIGN KEY ("template_id") REFERENCES "message_templates" ("id");

ALTER TABLE "surprises" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "surprise_dispatches" ADD FOREIGN KEY ("surprise_id") REFERENCES "surprises" ("id");

ALTER TABLE "surprise_dispatches" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "surprise_dispatches" ADD FOREIGN KEY ("message_log_id") REFERENCES "message_logs" ("id");

ALTER TABLE "chats" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "chat_messages" ADD FOREIGN KEY ("chat_id") REFERENCES "chats" ("id");

ALTER TABLE "assets" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
