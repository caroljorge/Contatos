unit ufrmContatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Vcl.Buttons;

type
  TForm1 = class(TForm)
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDConnection1: TFDConnection;
    lblConexao: TLabel;
    lblID: TLabel;
    lblNome: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    lblObservacoes: TLabel;
    edtID: TEdit;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    edtObservacoes: TMemo;
    BindSourcecontatos: TBindSourceDB;
    FDTablecontatos: TFDTable;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    btnInserir: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    DataSource1: TDataSource;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure HabilitaEdicao(Ativar: Boolean);
    procedure carrega;
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure limpa;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  if FDConnection1.Connected then
    lblConexao.Visible := True;

  HabilitaEdicao(False);
end;

procedure TForm1.HabilitaEdicao(Ativar: Boolean);
begin
  edtNome.Enabled        := Ativar;
  edtTelefone.Enabled    := Ativar;
  edtEmail.Enabled       := Ativar;
  edtObservacoes.Enabled := Ativar;
  btnSalvar.Enabled      := Ativar;
  btnCancelar.Enabled    := Ativar;
  btnInserir.Enabled     := Not(Ativar);
  btnEditar.Enabled      := Not(Ativar);
  btnExcluir.Enabled     := Not(Ativar);
  btnAnterior.Visible    := Not(Ativar);
  btnProximo.Visible     := Not(Ativar);
end;

procedure TForm1.btnAnteriorClick(Sender: TObject);
begin
  FDTablecontatos.Prior;
  Carrega;
end;

procedure TForm1.btnCancelarClick(Sender: TObject);
begin
  HabilitaEdicao(False);
  Limpa;
  Carrega;
  if edtID.Text = '0' then
    FDTablecontatos.Prior;
end;

procedure TForm1.btnEditarClick(Sender: TObject);
begin
  FDTablecontatos.Edit;
  HabilitaEdicao(True);
end;

procedure TForm1.btnExcluirClick(Sender: TObject);
begin
  FDTablecontatos.Delete;
end;

procedure TForm1.btnInserirClick(Sender: TObject);
begin
  FDTablecontatos.Insert;
  HabilitaEdicao(True);
end;

procedure TForm1.btnProximoClick(Sender: TObject);
begin
  FDTablecontatos.Next;
  Carrega;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
  FDTablecontatos.Post;
  Carrega;
  HabilitaEdicao(False);
  showmessage('Dados gravados com Sucesso!');
end;

procedure Tform1.Carrega;
begin
  edtID.Text          := IntToStr(FDTablecontatos.FieldByName('ID').AsInteger);
  edtNome.Text        := FDTablecontatos.FieldByName('NOME').AsString;
  edtTelefone.Text    := FDTablecontatos.FieldByName('TELEFONE').AsString;
  edtEmail.Text       := FDTablecontatos.FieldByName('EMAIL').AsString;
  edtObservacoes.Text := FDTablecontatos.FieldByName('OBSERVACOES').AsString;
end;

procedure Tform1.Limpa;
begin
  edtID.Text          := '';
  edtNome.Text        := '';
  edtTelefone.Text    := '';
  edtEmail.Text       := '';
  edtObservacoes.Text := '';
end;

end.
