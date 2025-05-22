USE [ESH]
GO

-- Insert admin user into CLIP.AspNetUsers table
INSERT INTO [CLIP].[AspNetUsers] (
    [Id],
    [Email],
    [EmailConfirmed],
    [PasswordHash],
    [SecurityStamp],
    [PhoneNumber],
    [PhoneNumberConfirmed],
    [TwoFactorEnabled],
    [LockoutEndDateUtc],
    [LockoutEnabled],
    [AccessFailedCount],
    [UserName],
    [EmpID],
    [DOE_CPD],
    [Atom_CEP],
    [Dosh_CEP]
)
VALUES (
    '48390d6e-9fad-49b8-ae54-9b3c15413397',
    'admin@example.com',
    0,
    'AP2aTrIZ7lInJOJhtvlt1CgItxaSZ5zKFIfDpev0lsZk8bidC/k2nURh0N31M2i5ew==',
    'b3628c99-bf11-45b9-bc80-758a58aa5775',
    '012 344455',
    0,
    0,
    NULL,
    1,
    0,
    'admin',
    'admin',
    123,
    456,
    NULL
);