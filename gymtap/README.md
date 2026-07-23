# GymTap — Base do Projeto

Estrutura inicial do app Flutter, seguindo a arquitetura definida:

```
UI (Telas) → Repository → (Isar + Services) → Firebase
```

## Como rodar

1. Instalar dependências:
   ```
   flutter pub get
   ```
2. Configurar o Firebase no projeto (`flutterfire configure`), gerando o
   `firebase_options.dart` e conectando os apps Android/iOS.
3. Rodar o app:
   ```
   flutter run
   ```

## O que já está pronto

- Estrutura de pastas completa (`nucleo/`, `aplicativo/`, `compartilhado/`,
  `funcionalidades/` com autenticação, treino, histórico, configurações e
  perfil).
- `main.dart` inicializando Isar (offline first) e depois o Firebase.
- `ProviderScope` do Riverpod configurado.
- Tema visual escuro com as cores oficiais do GymTap.
- Services base: `FirebaseService`, `AutenticacaoService`,
  `SincronizacaoService`.
- `IsarDatabase` com o ponto único de inicialização do banco local.
- Repository + Provider (Riverpod) de cada funcionalidade, ainda sem
  regras de negócio — prontos para receber os modelos (`modelos/`) e a
  lógica de cada uma.

## O que falta (próximos passos)

- Definir os `modelos/` (coleções Isar) de cada funcionalidade.
- Adicionar os schemas gerados ao `inicializarIsar()`.
- Implementar login (Google/e-mail/Facebook) no `AutenticacaoService`.
- Implementar as telas de cada funcionalidade.
- Implementar a sincronização real (Last Write Wins) por funcionalidade.

## Regras do projeto (não quebrar)

- A UI nunca acessa Isar, Services ou Firebase diretamente — só via
  Repository.
- Services só fazem integração externa, sem lógica de UI.
- Toda escrita ocorre primeiro no Isar (offline first).
- Código em português, exceto nomes de tecnologias/APIs externas.
