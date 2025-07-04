namespace my.company;

// using { UUID, timestamp } from '@sap/cds/common';

entity Users {
  key ID: UUID default uuid();
  name           : String(100);
  email          : String(150);
  documentId     : String(20);          // CPF, matrícula, etc.
  birthDate      : Date;
  gender         : String(20);
  phone          : String(20);

  role           : Association to Roles;
  seniority      : Association to Seniorities;
  team           : Association to Teams;
  manager        : Association to Users;

  isActive       : Boolean default true;
  createdAt      : Timestamp;
  updatedAt      : Timestamp;
}

entity Roles {
  key ID: UUID default uuid();
  name        : String(50);
  description : String;
}

entity Seniorities {
  key ID: UUID default uuid();
  name   : String(50);     // Ex: Júnior, Pleno, Sênior
  level  : Integer;
}

entity Teams {
  key ID: UUID default uuid();
  name        : String(100);
  description : String;
  leader      : Association to Users;

  members     : Composition of many Users on members.team = $self;
  createdAt   : Timestamp;
}

entity Projects {
  key ID: UUID default uuid();
  name        : String(100);
  description : String;
  status      : String(20);         // ativo, encerrado, pausado
  startDate   : Date;
  endDate     : Date;
  owner       : Association to Users;
  team        : Association to Teams;
  createdAt   : Timestamp;
}

entity Allocations {
  key ID: UUID default uuid();
  user           : Association to Users;
  project        : Association to Projects;
  roleInProject  : String(50);
  startDate      : Date;
  endDate        : Date;
}

entity Skills {
  key ID: UUID default uuid();
  name     : String(100);
  category : String(50);       // Técnica, Comportamental, Ferramenta
}

entity UserSkills {
  key ID: UUID default uuid();
  user        : Association to Users;
  skill       : Association to Skills;
  proficiency : Integer;       // 1 a 5
  lastUpdated : Date;
}

entity TeamMembershipHistory {
  key ID: UUID default uuid();
  user      : Association to Users;
  team      : Association to Teams;
  startDate : Date;
  endDate   : Date;
}
