namespace teamculture;

using { cuid, managed } from '@sap/cds/common';

type UUID : String(36);

// ENUMs / CodeLists
type ProjetoStatus : String enum {
  PRJ1 = 'PLANEJADO';
  PRJ2 = 'ATIVO';
  PRJ3 = 'CONCLUIDO';
  PRJ4 = 'SUSPENSO';
  PRJ5 = 'CANCELADO';
}

type CriticidadeLevel : Integer enum  {
  FIB1  = 1;
  FIB2  = 2;
  FIB3  = 3;
  FIB4  = 5;
  FIB5  = 8;
  FIB6  = 13;
  FIB7  = 21;
}

type PrazoType : Integer enum  {
  FIB1  = 1;
  FIB2  = 2;
  FIB3  = 3;
  FIB4  = 5;
  FIB5  = 8;
  FIB6  = 13;
  FIB7  = 21;
}

type CalendarioTipo : String enum  {
  Op1 = 'ANIVERSARIO';
  Op2 = 'ANIVERSARIO_EMPRESA';
  Op3 = 'AVALIACAO';
  Op4 = 'RECONHECIMENTO';
  Op5 = 'EVENTO';
}

// Parametros gerais
entity Params : cuid, managed {
  enabled  : Boolean = true;
  pacote   : String(64);
  keyValue : String(64);
  value    : String(255);
  descricao: String(500);
}

// Pessoas / Funcionarios
entity Funcionarios : cuid, managed {
  nome          : String(200);
  apelido       : String(100);
  email         : String(200);
  ativo         : Boolean = true;
  dataAdmissao  : Date;
  dataNascimento: Date;
  telefone      : String(30);
  cargo         : Association to Cargos;
  time          : Association to Times;
  empresa       : Association to Empresas;
  // relacionamentos
  skills        : Composition of many FuncionariosSkills on skills.funcionario = $self;
  projetos      : Composition of many FuncionariosProjetos on projetos.funcionario = $self;
}

// Cargos e hierarquia
entity Cargos : cuid, managed {
  titulo     : String(150);
  descricao  : String(500);
  nivel      : Integer;
  parent     : Association to Cargos; // hierarquia
}

entity CargosHierarquia : cuid, managed {
  cargo      : Association to Cargos;
  superior   : Association to Cargos;
  nivelRel   : Integer;
}

// Skills
entity Skills : cuid, managed {
  nome       : String(150);
  descricao  : String(500);
  area       : String(100);
  nivelMax   : Integer;
}

entity FuncionariosSkills : cuid, managed {
  funcionario : Association to Funcionarios;
  skill       : Association to Skills;
  nivel       : Integer; // 1..10
  anosExp     : Decimal(5,2);
  certificado : Boolean;
  observacao  : String(500);
}

// Times / Teams
entity Times : cuid, managed {
  nome        : String(150);
  descricao   : String(500);
  lider       : Association to Funcionarios;
  empresa     : Association to Empresas;
  membros     : Composition of many FuncionariosTime on membros.time = $self;
  metas       : Composition of many MetasTime on metas.time = $self;
}

// Vinculo funcionario <-> time
entity FuncionariosTime : cuid, managed {
  funcionario : Association to Funcionarios;
  time        : Association to Times;
  dataEntrada : Date;
  dataSaida   : Date;
  rol         : String(100);
  ativo       : Boolean = true;
}

// Empresas e projetos
entity Empresas : cuid, managed {
  nome        : String(200);
  cnpj        : String(20);
  contato     : String(200);
  endereco    : String(500);
  projetos    : Composition of many EmpresaProjetos on projetos.empresa = $self;
  metas       : Composition of many MetasEmpresa on metas.empresa = $self;
}

entity Projetos : cuid, managed {
  nome        : String(250);
  codigo      : String(50);
  descricao   : String(1000);
  status      : ProjetoStatus = 'PRJ1';
  dataInicio  : Date;
  dataFim     : Date;
  budget      : Decimal(18,2);
  empresa     : Association to Empresas;
  times       : Association to Times; // projeto pode ter time responsável
  funcionarios: Composition of many FuncionariosProjetos on funcionarios.projeto = $self;
  metas       : Composition of many MetasProjeto on metas.projeto = $self;
  criticidade : CriticidadeLevel;
}

// Join many-to-many funcionario <-> projeto
entity FuncionariosProjetos : cuid, managed {
  funcionario : Association to Funcionarios;
  projeto     : Association to Projetos;
  papel       : String(100);
  horasAlocadas: Decimal(10,2);
  dataInicio  : Date;
  dataFim     : Date;
  ativo       : Boolean = true;
}

// EmpresaProjetos (se precisar de info adicional por relacionamento)
entity EmpresaProjetos : cuid, managed {
  empresa : Association to Empresas;
  projeto : Association to Projetos;
  contrato: String(200);
}

// Perguntas / Respostas (Q&A, pesquisas)
entity TipoPerguntas : cuid, managed {
  nome      : String(150);
  descricao : String(500);
}

entity Perguntas : cuid, managed {
  texto     : String(2000);
  tipo      : Association to TipoPerguntas;
  obrigatoria: Boolean = false;
  autor     : Association to Funcionarios;
  dataCriacao: Timestamp;
}

entity Respostas : cuid, managed {
  pergunta  : Association to Perguntas;
  autor     : Association to Funcionarios;
  texto     : String(2000);
  data      : Timestamp;
  nota      : Integer;
}

// Observacoes / tipoObservacao
entity TipoObservacao : cuid, managed {
  nome      : String(150);
  descricao : String(500);
}

entity Observacoes : cuid, managed {
  tipo      : Association to TipoObservacao;
  autor     : Association to Funcionarios;
  alvoFuncionario : Association to Funcionarios;
  alvoProjeto     : Association to Projetos;
  texto     : String(2000);
  anexos    : String(1000);
  data      : Timestamp;
}

// Metas (Time, Pessoa, Projeto, Empresa)
entity MetasTime : cuid, managed {
  time      : Association to Times;
  titulo    : String(200);
  descricao : String(1000);
  target    : Decimal(18,4);
  medida    : String(50);
  progresso : Decimal(5,2);
  dataInicio: Date;
  dataFim   : Date;
}

entity MetasPessoa : cuid, managed {
  funcionario: Association to Funcionarios;
  titulo    : String(200);
  descricao : String(1000);
  target    : Decimal(18,4);
  medida    : String(50);
  progresso : Decimal(5,2);
  dataInicio: Date;
  dataFim   : Date;
}

entity MetasProjeto : cuid, managed {
  projeto   : Association to Projetos;
  titulo    : String(200);
  descricao : String(1000);
  target    : Decimal(18,4);
  medida    : String(50);
  progresso : Decimal(5,2);
  dataInicio: Date;
  dataFim   : Date;
}

entity MetasEmpresa : cuid, managed {
  empresa   : Association to Empresas;
  titulo    : String(200);
  descricao : String(1000);
  target    : Decimal(18,4);
  medida    : String(50);
  progresso : Decimal(5,2);
  dataInicio: Date;
  dataFim   : Date;
}

// Criticidade / Prazo / Reconhecimento
entity Criticidade : cuid, managed {
  nivel     : CriticidadeLevel;
  descricao : String(500);
}

entity Prazo : cuid, managed {
  tipo      : PrazoType;
  dias      : Integer;
  descricao : String(500);
}

entity Reconhecimento : cuid, managed {
  codigo    : String(50);
  titulo    : String(200);
  descricao : String(1000);
  pontos    : Integer;
}

// Calendario (eventos variados)
entity Calendario : cuid, managed {
  tipo      : CalendarioTipo;
  titulo    : String(200);
  descricao : String(1000);
  dataInicio: Date;
  dataFim   : Date;
  funcionario: Association to Funcionarios; // opcional
  empresa   : Association to Empresas; // opcional
  projeto   : Association to Projetos; // opcional
  observacao : String(1000);
}

// Engajamentos (controle por entidade)
entity ControleEngajamentosProjeto : cuid, managed {
  projeto   : Association to Projetos;
  indicador : String(150);
  valor     : Decimal(18,4);
  data      : Date;
  observacao: String(500);
}

entity ControleEngajamentosFuncionario : cuid, managed {
  funcionario: Association to Funcionarios;
  indicador : String(150);
  valor     : Decimal(18,4);
  data      : Date;
  observacao: String(500);
}

entity ControleEngajamentosTime : cuid, managed {
  time      : Association to Times;
  indicador : String(150);
  valor     : Decimal(18,4);
  data      : Date;
  observacao: String(500);
}

entity ControleEngajamentosEmpresa : cuid, managed {
  empresa   : Association to Empresas;
  indicador : String(150);
  valor     : Decimal(18,4);
  data      : Date;
  observacao: String(500);
}

// Threads de discussao / mensagens
entity ThreadsDiscucao : cuid, managed {
  titulo     : String(250);
  criador    : Association to Funcionarios;
  dataCriacao: Timestamp;
  fechado    : Boolean = false;
  mensagens  : Composition of many Mensagems on mensagens.thread = $self;
}

entity Mensagems : cuid, managed {
  thread     : Association to ThreadsDiscucao;
  autor      : Association to Funcionarios;
  texto      : String(4000);
  data       : Timestamp;
  respostaPara: Association to Mensagems;
  anexos     : String(1000);
}

// Apontamento de horas
entity ApontamentoHorasFuncionario : cuid, managed {
  funcionario: Association to Funcionarios;
  projeto    : Association to Projetos;
  data       : Date;
  horas      : Decimal(5,2);
  descricao  : String(2000);
  tipo       : String(100);
}

// Andamento de projetos (logs / checkpoints)
entity AndamentoProjeto : cuid, managed {
  projeto   : Association to Projetos;
  data      : Timestamp;
  titulo    : String(250);
  descricao : String(2000);
  responsavel: Association to Funcionarios;
}