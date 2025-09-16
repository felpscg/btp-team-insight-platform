using my.company as db from '../db/schema';
using teamculture as teamculture from '../db/schemaFeedback';
service MainService {
  entity Tasks             as projection on db.Tasks;
  entity TaskStatuses      as projection on db.TaskStatuses;
  entity TaskComments      as projection on db.TaskComments;
  entity TaskTags          as projection on db.TaskTags;
  entity TaskTagMap        as projection on db.TaskTagMap;
  entity TaskStatusHistory as projection on db.TaskStatusHistory;

  entity TeamMembers       as projection on db.TeamMembers;
  entity TeamCheckins      as projection on db.TeamCheckins;
  entity TeamMoodWeekly    as projection on db.TeamMoodWeekly; // opcional, pode virar view
//   // Pessoas
  entity Users as projection on db.Users;
  entity Roles as projection on db.Roles;
  entity Seniorities as projection on db.Seniorities;

  // Equipes
  entity Teams as projection on db.Teams;
  // entity TeamMembershipHistory as projection on db.TeamMembershipHistory;

  // Projetos
  entity Projects as projection on db.Projects;
  entity Allocations as projection on db.Allocations;

  // Competências
  entity Skills as projection on db.Skills;
  entity UserSkills as projection on db.UserSkills;


}
service Feedbacks{
    entity Employees   as projection on teamculture.Employees;
  entity Teams       as projection on teamculture.Teams;
  entity Skills      as projection on teamculture.Skills;
  entity EmployeeSkills      as projection on teamculture.EmployeeSkills;
  entity Surveys     as projection on teamculture.Surveys;
  entity Questions   as projection on teamculture.Questions;
  entity Responses   as projection on teamculture.Responses;
  entity Feedbacks   as projection on teamculture.Feedbacks;
}
// service MainService {

//   // Pessoas
//   entity Users as projection on db.Users;
//   entity Roles as projection on db.Roles;
//   entity Seniorities as projection on db.Seniorities;

//   // Equipes
//   entity Teams as projection on db.Teams;
//   entity TeamMembershipHistory as projection on db.TeamMembershipHistory;

//   // Projetos
//   entity Projects as projection on db.Projects;
//   entity Allocations as projection on db.Allocations;

//   // Competências
//   entity Skills as projection on db.Skills;
//   entity UserSkills as projection on db.UserSkills;

// }