namespace teamculture;

using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

// -------------------- ENUMS --------------------
type FeedbackType : String enum {
  Positive   = 'POSITIVE';
  Constructive = 'CONSTRUCTIVE';
  Anonymous  = 'ANONYMOUS';
}

type QuestionType : String enum {
  Rating    = 'RATING';     // Escala numérica 1-5
  Boolean   = 'BOOLEAN';    // Sim/Não
  Text      = 'TEXT';       // Resposta aberta
}

// -------------------- ENTIDADES --------------------
entity Employees : cuid, managed {
  name        : String(100);
  email       : String(100);
  role        : String(50);
  hireDate    : Date;
  active      : Boolean default true;

  team        : Association to Teams;
  skills      : Association to many EmployeeSkills on skills.employee = $self;
}

entity Skills : cuid {
  name        : String(50);
  description : String(255);
  employees   : Association to many EmployeeSkills on employees.skill = $self;
}

// --- Join Table (N:N) ---
entity EmployeeSkills : cuid {
  employee    : Association to Employees;
  skill       : Association to Skills;
  level       : Integer;   // opcional: 1=junior, 5=expert
  acquiredAt  : Date;
}

entity Teams : cuid, managed {
  name        : String(100);
  area        : String(100);
  leader      : Association to Employees;
  members     : Association to many Employees on members.team = $self;
  surveys     : Association to many Surveys on surveys.team = $self;
}


// -------------------- PESQUISAS --------------------
entity Surveys : cuid, managed {
  title       : String(100);
  description : String(255);
  startDate   : Date;
  endDate     : Date;
  team        : Association to Teams;
  questions   : Composition of many Questions on questions.survey = $self;
  responses   : Composition of many Responses on responses.survey = $self;
}

entity Questions : cuid, managed {
  survey      : Association to Surveys;
  text        : String(255);
  type        : QuestionType;
  options     : Composition of many QuestionOptions on options.question = $self; // ex. escala 1–5
}

entity QuestionOptions : cuid {
  question    : Association to Questions;
  label       : String(100);
  value       : Integer;
}

// -------------------- RESPOSTAS --------------------
entity Responses : cuid, managed {
  survey      : Association to Surveys;
  question    : Association to Questions;
  employee    : Association to Employees;
  answerText  : String(500);
  answerValue : Integer;   // para respostas numéricas
  createdAt   : Timestamp;
}

// -------------------- FEEDBACK --------------------
entity Feedbacks : cuid, managed {
  employee    : Association to Employees;
  sender      : String(100);
  content     : String(500);
  type        : FeedbackType;
  createdAt   : Timestamp;
}