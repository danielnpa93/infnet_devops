CREATE TABLE IF NOT EXISTS "AspNetRoles" (
    "Id" VARCHAR NOT NULL PRIMARY KEY,
    "Name" VARCHAR NULL,
    "NormalizedName" VARCHAR NULL,
    "ConcurrencyStamp" VARCHAR NULL
);

CREATE TABLE IF NOT EXISTS "AspNetRoleClaims" (
    "Id" SERIAL PRIMARY KEY,
    "RoleId" VARCHAR NOT NULL REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE,
    "ClaimType" VARCHAR NULL,
    "ClaimValue" VARCHAR NULL
);

CREATE TABLE IF NOT EXISTS "AspNetUsers" (
    "Id" VARCHAR NOT NULL PRIMARY KEY,
    "UserName" VARCHAR NULL,
    "NormalizedUserName" VARCHAR NULL,
    "Email" VARCHAR NULL,
    "NormalizedEmail" VARCHAR NULL,
    "EmailConfirmed" BOOLEAN NOT NULL,
    "PasswordHash" VARCHAR NULL,
    "SecurityStamp" VARCHAR NULL,
    "ConcurrencyStamp" VARCHAR NULL,
    "PhoneNumber" VARCHAR NULL,
    "PhoneNumberConfirmed" BOOLEAN NOT NULL,
    "TwoFactorEnabled" BOOLEAN NOT NULL,
    "LockoutEnd" TIMESTAMPTZ NULL,
    "LockoutEnabled" BOOLEAN NOT NULL,
    "AccessFailedCount" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "AspNetUserClaims" (
    "Id" SERIAL PRIMARY KEY,
    "UserId" VARCHAR NOT NULL REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE,
    "ClaimType" VARCHAR NULL,
    "ClaimValue" VARCHAR NULL
);

CREATE TABLE IF NOT EXISTS "AspNetUserLogins" (
    "LoginProvider" VARCHAR NOT NULL,
    "ProviderKey" VARCHAR NOT NULL,
    "ProviderDisplayName" VARCHAR NULL,
    "UserId" VARCHAR NOT NULL REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE,
    PRIMARY KEY ("LoginProvider", "ProviderKey")
);

CREATE TABLE IF NOT EXISTS "AspNetUserRoles" (
    "UserId" VARCHAR NOT NULL REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE,
    "RoleId" VARCHAR NOT NULL REFERENCES "AspNetRoles"("Id") ON DELETE CASCADE,
    PRIMARY KEY ("UserId", "RoleId")
);

CREATE TABLE IF NOT EXISTS "AspNetUserTokens" (
    "UserId" VARCHAR NOT NULL REFERENCES "AspNetUsers"("Id") ON DELETE CASCADE,
    "LoginProvider" VARCHAR NOT NULL,
    "Name" VARCHAR NOT NULL,
    "Value" VARCHAR NULL,
    PRIMARY KEY ("UserId", "LoginProvider", "Name")
);

CREATE TABLE IF NOT EXISTS "SecurityKeys" (
    "Id" UUID PRIMARY KEY,
    "Parameters" TEXT,
    "KeyId" TEXT,
    "Type" TEXT,
    "Algorithm" TEXT,
    "CreationDate" TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS "RefreshTokens" (
    "Id" UUID PRIMARY KEY,
    "Username" TEXT,
    "Token" UUID NOT NULL,
    "ExpirationDate" TIMESTAMP NOT NULL
);