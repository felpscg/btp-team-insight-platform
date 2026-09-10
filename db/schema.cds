namespace my.company;

// using { cuid, timestamp } from '@sap/cds/common';

// ==========================
// PESSOAS, TIMES E PROJETOS
// ==========================

type genderType : Integer enum {
  @title: 'Masculino' Male = 1;
  @title: 'Feminino' Feminino = 2;
  @title: 'Outro' Other = 3;
}
entity Users {
  key ID         : UUID default uuid();
  name           : String(100);
  email          : String(150);
  documentId     : String(20);
  birthDate      : Date;
  gender         : genderType;
  phone          : String(20);

  role           : Association to Roles;
  seniority      : Association to Seniorities;
  manager        : Association to Users;

  isActive       : Boolean default true;
  createdAt      : Timestamp default current_timestamp;
  updatedAt      : Timestamp default current_timestamp;
}

entity Roles {
  key ID         : UUID default uuid();
  name           : String(50);
  description    : String;
}

entity Seniorities {
  key ID         : UUID default uuid();
  name           : String(50);
  level          : Integer;
}

entity Teams {
  key ID         : UUID default uuid();
  name           : String(100);
  description    : String;
  leader         : Association to Users;
  createdAt      : Timestamp;
}

entity TeamMembers {
  key ID         : UUID default uuid();
  user           : Association to Users;
  team           : Association to Teams;
  joinedAt       : Date;
  leftAt         : Date;
}

entity Projects {
  key ID         : UUID default uuid();
  name           : String(100);
  description    : String;
  status         : String(20);
  startDate      : Date;
  endDate        : Date;
  owner          : Association to Users;
  team           : Association to Teams;
  createdAt      : Timestamp;
}

entity Allocations {
  key ID         : UUID default uuid();
  user           : Association to Users;
  project        : Association to Projects;
  roleInProject  : String(50);
  startDate      : Date;
  endDate        : Date;
}

// ==========================
// HABILIDADES E PERFIL
// ==========================

entity Skills {
  key ID         : UUID default uuid();
  name           : String(100);
  category       : String(50);
}

entity UserSkills {
  key ID         : UUID default uuid();
  user           : Association to Users;
  skill          : Association to Skills;
  proficiency    : Integer;
  lastUpdated    : Date;
}

// ==========================
// TAREFAS E WORKFLOW
// ==========================

entity TaskStatuses {
  key ID         : UUID default uuid();
  code           : String(20);
  label          : String(50);
  order          : Integer;
}

entity Tasks {
  key ID         : UUID default uuid();
  title          : String(150);
  description    : String;
  status         : Association to TaskStatuses;
  priority       : String(20);
  dueDate        : Date;

  project        : Association to Projects;
  createdBy      : Association to Users;
  assignedTo     : Association to Users;

  createdAt      : Timestamp;
  updatedAt      : Timestamp;
}

entity TaskComments {
  key ID         : UUID default uuid();
  task           : Association to Tasks;
  author         : Association to Users;
  comment        : String;
  createdAt      : Timestamp;
}

entity TaskTags {
  key ID         : UUID default uuid();
  name           : String(50);
  color          : String(10);
}

entity TaskTagMap {
  key ID         : UUID default uuid();
  task           : Association to Tasks;
  tag            : Association to TaskTags;
}

entity TaskStatusHistory {
  key ID         : UUID default uuid();
  task           : Association to Tasks;
  fromStatus     : Association to TaskStatuses;
  toStatus       : Association to TaskStatuses;
  changedBy      : Association to Users;
  changedAt      : Timestamp;
}

// ==========================
// CLIMA ORGANIZACIONAL
// ==========================

entity TeamCheckins {
  key ID         : UUID default uuid();
  team           : Association to Teams;
  user           : Association to Users;
  mood           : Integer;
  comment        : String;
  checkinDate    : Date;
  createdAt      : Timestamp;
}

entity TeamMoodWeekly {
  key teamID     : UUID;
  key weekStart  : Date;
  avgMood        : Decimal(3,2);
  totalEntries   : Integer;
}
