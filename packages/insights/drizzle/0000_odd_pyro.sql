CREATE TABLE `account` (
	`userId` text NOT NULL,
	`type` text NOT NULL,
	`provider` text NOT NULL,
	`providerAccountId` text NOT NULL,
	`refresh_token` text,
	`access_token` text,
	`expires_at` integer,
	`token_type` text,
	`scope` text,
	`id_token` text,
	`session_state` text,
	PRIMARY KEY(`provider`, `providerAccountId`),
	FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `applications` (
	`id` integer PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`description` text,
	`url` text,
	`public_api_key` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `edges` (
	`id` integer PRIMARY KEY NOT NULL,
	`public_api_key` text,
	`manifest_hash` text NOT NULL,
	`from` text,
	`to` text NOT NULL,
	`interaction` integer NOT NULL,
	`delay_count_00` integer NOT NULL,
	`delay_count_01` integer NOT NULL,
	`delay_count_02` integer NOT NULL,
	`delay_count_03` integer NOT NULL,
	`delay_count_04` integer NOT NULL,
	`delay_count_05` integer NOT NULL,
	`delay_count_06` integer NOT NULL,
	`delay_count_07` integer NOT NULL,
	`delay_count_08` integer NOT NULL,
	`delay_count_09` integer NOT NULL,
	`delay_count_10` integer NOT NULL,
	`delay_count_11` integer NOT NULL,
	`delay_count_12` integer NOT NULL,
	`delay_count_13` integer NOT NULL,
	`delay_count_14` integer NOT NULL,
	`delay_count_15` integer NOT NULL,
	`delay_count_16` integer NOT NULL,
	`delay_count_17` integer NOT NULL,
	`delay_count_18` integer NOT NULL,
	`delay_count_19` integer NOT NULL,
	`delay_count_20` integer NOT NULL,
	`delay_count_21` integer NOT NULL,
	`delay_count_22` integer NOT NULL,
	`delay_count_23` integer NOT NULL,
	`delay_count_24` integer NOT NULL,
	`delay_count_25` integer NOT NULL,
	`delay_count_26` integer NOT NULL,
	`delay_count_27` integer NOT NULL,
	`delay_count_28` integer NOT NULL,
	`delay_count_29` integer NOT NULL,
	`delay_count_30` integer NOT NULL,
	`delay_count_31` integer NOT NULL,
	`delay_count_32` integer NOT NULL,
	`delay_count_33` integer NOT NULL,
	`delay_count_34` integer NOT NULL,
	`delay_count_35` integer NOT NULL,
	`delay_count_36` integer NOT NULL,
	`delay_count_37` integer NOT NULL,
	`delay_count_38` integer NOT NULL,
	`delay_count_39` integer NOT NULL,
	`delay_count_40` integer NOT NULL,
	`delay_count_41` integer NOT NULL,
	`delay_count_42` integer NOT NULL,
	`delay_count_43` integer NOT NULL,
	`delay_count_44` integer NOT NULL,
	`delay_count_45` integer NOT NULL,
	`delay_count_46` integer NOT NULL,
	`delay_count_47` integer NOT NULL,
	`delay_count_48` integer NOT NULL,
	`delay_count_49` integer NOT NULL,
	`latency_count_00` integer NOT NULL,
	`latency_count_01` integer NOT NULL,
	`latency_count_02` integer NOT NULL,
	`latency_count_03` integer NOT NULL,
	`latency_count_04` integer NOT NULL,
	`latency_count_05` integer NOT NULL,
	`latency_count_06` integer NOT NULL,
	`latency_count_07` integer NOT NULL,
	`latency_count_08` integer NOT NULL,
	`latency_count_09` integer NOT NULL,
	`latency_count_10` integer NOT NULL,
	`latency_count_11` integer NOT NULL,
	`latency_count_12` integer NOT NULL,
	`latency_count_13` integer NOT NULL,
	`latency_count_14` integer NOT NULL,
	`latency_count_15` integer NOT NULL,
	`latency_count_16` integer NOT NULL,
	`latency_count_17` integer NOT NULL,
	`latency_count_18` integer NOT NULL,
	`latency_count_19` integer NOT NULL,
	`latency_count_20` integer NOT NULL,
	`latency_count_21` integer NOT NULL,
	`latency_count_22` integer NOT NULL,
	`latency_count_23` integer NOT NULL,
	`latency_count_24` integer NOT NULL,
	`latency_count_25` integer NOT NULL,
	`latency_count_26` integer NOT NULL,
	`latency_count_27` integer NOT NULL,
	`latency_count_28` integer NOT NULL,
	`latency_count_29` integer NOT NULL,
	`latency_count_30` integer NOT NULL,
	`latency_count_31` integer NOT NULL,
	`latency_count_32` integer NOT NULL,
	`latency_count_33` integer NOT NULL,
	`latency_count_34` integer NOT NULL,
	`latency_count_35` integer NOT NULL,
	`latency_count_36` integer NOT NULL,
	`latency_count_37` integer NOT NULL,
	`latency_count_38` integer NOT NULL,
	`latency_count_39` integer NOT NULL,
	`latency_count_40` integer NOT NULL,
	`latency_count_41` integer NOT NULL,
	`latency_count_42` integer NOT NULL,
	`latency_count_43` integer NOT NULL,
	`latency_count_44` integer NOT NULL,
	`latency_count_45` integer NOT NULL,
	`latency_count_46` integer NOT NULL,
	`latency_count_47` integer NOT NULL,
	`latency_count_48` integer NOT NULL,
	`latency_count_49` integer NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `errors` (
	`id` integer PRIMARY KEY NOT NULL,
	`public_api_key` text,
	`manifest_hash` text,
	`timestamp` integer NOT NULL,
	`url` text NOT NULL,
	`source` text NOT NULL,
	`line` integer NOT NULL,
	`column` integer NOT NULL,
	`message` text NOT NULL,
	`error` text NOT NULL,
	`stack` text NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`manifest_hash`) REFERENCES `manifests`(`hash`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `manifests` (
	`id` integer PRIMARY KEY NOT NULL,
	`public_api_key` text,
	`hash` text NOT NULL,
	`timestamp` integer NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `routes` (
	`id` integer PRIMARY KEY NOT NULL,
	`public_api_key` text,
	`manifest_hash` text NOT NULL,
	`route` text NOT NULL,
	`symbol` text NOT NULL,
	`timeline_00` integer NOT NULL,
	`timeline_01` integer NOT NULL,
	`timeline_02` integer NOT NULL,
	`timeline_03` integer NOT NULL,
	`timeline_04` integer NOT NULL,
	`timeline_05` integer NOT NULL,
	`timeline_06` integer NOT NULL,
	`timeline_07` integer NOT NULL,
	`timeline_08` integer NOT NULL,
	`timeline_09` integer NOT NULL,
	`timeline_10` integer NOT NULL,
	`timeline_11` integer NOT NULL,
	`timeline_12` integer NOT NULL,
	`timeline_13` integer NOT NULL,
	`timeline_14` integer NOT NULL,
	`timeline_15` integer NOT NULL,
	`timeline_16` integer NOT NULL,
	`timeline_17` integer NOT NULL,
	`timeline_18` integer NOT NULL,
	`timeline_19` integer NOT NULL,
	`timeline_20` integer NOT NULL,
	`timeline_21` integer NOT NULL,
	`timeline_22` integer NOT NULL,
	`timeline_23` integer NOT NULL,
	`timeline_24` integer NOT NULL,
	`timeline_25` integer NOT NULL,
	`timeline_26` integer NOT NULL,
	`timeline_27` integer NOT NULL,
	`timeline_28` integer NOT NULL,
	`timeline_29` integer NOT NULL,
	`timeline_30` integer NOT NULL,
	`timeline_31` integer NOT NULL,
	`timeline_32` integer NOT NULL,
	`timeline_33` integer NOT NULL,
	`timeline_34` integer NOT NULL,
	`timeline_35` integer NOT NULL,
	`timeline_36` integer NOT NULL,
	`timeline_37` integer NOT NULL,
	`timeline_38` integer NOT NULL,
	`timeline_39` integer NOT NULL,
	`timeline_40` integer NOT NULL,
	`timeline_41` integer NOT NULL,
	`timeline_42` integer NOT NULL,
	`timeline_43` integer NOT NULL,
	`timeline_44` integer NOT NULL,
	`timeline_45` integer NOT NULL,
	`timeline_46` integer NOT NULL,
	`timeline_47` integer NOT NULL,
	`timeline_48` integer NOT NULL,
	`timeline_49` integer NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `session` (
	`sessionToken` text PRIMARY KEY NOT NULL,
	`userId` text NOT NULL,
	`expires` integer NOT NULL,
	FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `symbolDetail` (
	`id` integer PRIMARY KEY NOT NULL,
	`hash` text NOT NULL,
	`public_api_key` text,
	`manifest_hash` text,
	`full_name` text NOT NULL,
	`origin` text NOT NULL,
	`lo` integer NOT NULL,
	`hi` integer NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`public_api_key`,`manifest_hash`) REFERENCES `manifests`(`public_api_key`,`hash`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `symbols` (
	`id` integer PRIMARY KEY NOT NULL,
	`public_api_key` text,
	`pathname` text NOT NULL,
	`interaction` integer NOT NULL,
	`symbol` text NOT NULL,
	`prev_symbol` text,
	`time_delta_ms` integer NOT NULL,
	`load_delay_ms` integer NOT NULL,
	FOREIGN KEY (`public_api_key`) REFERENCES `applications`(`public_api_key`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `userApplicationMap` (
	`application_id` integer,
	`user_id` integer,
	FOREIGN KEY (`application_id`) REFERENCES `applications`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `user` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text,
	`email` text NOT NULL,
	`emailVerified` integer,
	`image` text,
	`created` integer DEFAULT (cast((julianday('now') - 2440587.5)*86400000 as integer)) NOT NULL,
	`super_user` integer DEFAULT false NOT NULL
);
--> statement-breakpoint
CREATE TABLE `verificationToken` (
	`identifier` text NOT NULL,
	`token` text NOT NULL,
	`expires` integer NOT NULL,
	PRIMARY KEY(`identifier`, `token`)
);
--> statement-breakpoint
CREATE UNIQUE INDEX `publicApiKeyIndex` ON `applications` (`public_api_key`);--> statement-breakpoint
CREATE INDEX `edgeIndex_PublicApiKey` ON `edges` (`public_api_key`);--> statement-breakpoint
CREATE INDEX `edgeIndex_PublicApiKey_manifestHash` ON `edges` (`public_api_key`,`manifest_hash`);--> statement-breakpoint
CREATE UNIQUE INDEX `edgeIndex` ON `edges` (`public_api_key`,`manifest_hash`,`from`,`to`);--> statement-breakpoint
CREATE UNIQUE INDEX `hashIndex` ON `manifests` (`hash`,`public_api_key`);--> statement-breakpoint
CREATE UNIQUE INDEX `routeIndex_Symbol` ON `routes` (`public_api_key`,`manifest_hash`,`route`,`symbol`);--> statement-breakpoint
CREATE UNIQUE INDEX `userApplicationIndex` ON `userApplicationMap` (`application_id`,`user_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `emailIndex` ON `user` (`email`);