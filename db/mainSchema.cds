namespace teamculture;

using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

entity Params : cuid, managed {
  enabled : Boolean default true;
  pacote : String(10);
  keyValue : String(4);
  value : String(15);
}
entity Funcionarios : cuid, managed {
}
entity Skills : cuid, managed {
}
entity FuncionariosSkills : cuid, managed {
}
entity Cargos : cuid, managed {
}
entity CargosHierarquia : cuid, managed {
}
entity NovaSkill : cuid, managed {
}
entity Projetos : cuid, managed {
}
entity Times : cuid, managed {
}
entity FuncionariosProjetos : cuid, managed {
}
entity FuncionariosTime : cuid, managed {
}
entity Empresas : cuid, managed {
}
entity EmpresaProjetos : cuid, managed {
}
entity Perguntas : cuid, managed {
}
entity Respostas : cuid, managed {
}
entity TipoPerguntas : cuid, managed {
}
entity Observacoes : cuid, managed {
}
entity TipoObservacao : cuid, managed {
}
entity MetasTime : cuid, managed {
}
entity MetasPessoa : cuid, managed {
}
entity MetasProjeto : cuid, managed {
}
entity MetasEmpresa : cuid, managed {
}
entity Criticidade  : cuid, managed {
    // Fibonatti
}
entity Prazo  : cuid, managed {
    // Fibonatti
}
entity Reconhecimento  : cuid, managed {
    
}
entity Calendário  : cuid, managed {
    // Data de Aniversário
    // Aniversário de anos de empresa
    // avaliações
    // Notas de Reconhecimento com nome e descrição do Reconhecimento
    // eventos internos,
    // ...
}
entity ControleEngajamentosProjeto  : cuid, managed {
}
entity ControleEngajamentosFuncionario  : cuid, managed {
}
entity ControleEngajamentosTime  : cuid, managed {
}
entity ControleEngajamentosEmpresa  : cuid, managed {
}
entity ThreadsDiscucao  : cuid, managed {
}
entity ApontamentoHorasFuncionario  : cuid, managed {
}
entity AndamentoProjeto : cuid, managed {
}
