-- Rename Atom_CEP to Atom_CEP
EXEC sp_rename 'AspNetUsers.CPD_Points', 'Atom_CEP', 'COLUMN';

-- Rename DOE_CPD to DOE_CPD
EXEC sp_rename 'AspNetUsers.DOE_CPD', 'DOE_CPD', 'COLUMN';

-- Add new column Dosh_CEP with default value 0
ALTER TABLE AspNetUsers
ADD Dosh_CEP INT NULL CONSTRAINT DF_AspNetUsers_Dosh_CEP DEFAULT 0;
