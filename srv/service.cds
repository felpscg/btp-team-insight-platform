using my.company as db from '../db/schema';

service MainService {

  // Pessoas
  entity Users as projection on db.Users;
  entity Roles as projection on db.Roles;
  entity Seniorities as projection on db.Seniorities;

  // Equipes
  entity Teams as projection on db.Teams;
  entity TeamMembershipHistory as projection on db.TeamMembershipHistory;

  // Projetos
  entity Projects as projection on db.Projects;
  entity Allocations as projection on db.Allocations;

  // Competências
  entity Skills as projection on db.Skills;
  entity UserSkills as projection on db.UserSkills;

}