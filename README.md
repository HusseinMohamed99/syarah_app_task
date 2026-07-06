# Todo App

A Flutter Todo application built to match the architecture, tooling, and conventions of the Tuwaiq Pay production codebase — Clean-Architecture-lite, Riverpod v3 (code-generated), go_router, and a shared design-system core.

## Tech Stack

| Layer            | Choice                                                                          |
| -----------------| ------------------------------------------------------------------------------- |
| State management | Riverpod v3 with code generation (`riverpod_annotation` / `riverpod_generator`) |
| Networking       | Single shared `Dio` instance behind `BaseApiClient`                             |
| Models           | `@JsonSerializable` DTOs + `@freezed` domain models                             |
| Routing          | `go_router` + `go_router_builder` (typed routes)                                |
| Theming          | `ColorManager` + `context.*` text-style extensions + `flutter_screenutil`       |
| Error handling   | `ApiResult<T>` (freezed `Success`/`Failure` union) + `NetworkException`         |

## Data Source

[`https://jsonplaceholder.typicode.com/todos`](https://jsonplaceholder.typicode.com/todos) — a fake REST API. `GET` requests return real data; `POST` / `PUT` / `DELETE` return success responses (200/201) but do **not** persist anything server-side. The app updates local state optimistically after a successful mutation instead of refetching from the server.

## Features

### Todo List

- Paginated fetch (`GET /todos?_page=&_limit=`) with infinite scroll
- Loading, empty, error, and loaded states, each with its own visual treatment
- Pull-to-refresh (resets back to page 1)
- Client-side search/filter by title across all currently loaded todos
- Custom card design for each todo (not a stock `ListTile`) with a distinct completed/pending treatment

### Add / Edit Todo

- Add a new todo
- Edit an existing todo
- Delete a todo (swipe or confirm dialog)

### Error Handling

- No internet connection
- Request timeout
- Server error (4xx / 5xx)

All user-facing strings are in English.

## Project Structure

```text
lib/
├── core/                          # Cross-cutting infrastructure
│   ├── network/                   # BaseApiClient, Dio provider, interceptors,
│   │                               # ApiResult, NetworkException, NetworkErrorHandler
│   ├── routing/                   # AppPaths, typed go_router routes, appRouterProvider
│   ├── theming/                   # ColorManager, text-style extensions, light/dark themes
│   ├── helpers/
│   │   ├── dimensions/            # k*-prefixed spacing/sizing constants
│   │   ├── extensions/            # Widget & BuildContext extensions
│   │   └── functions/             # getNetworkErrorMessage() and similar helpers
│   └── widgets/                   # CustomErrorWidget, MissingDataView, AppSkeleton,
│                                   # AdaptiveLoadingIndicator, CustomButton, CustomTextFormField
│
└── features/todos/
    ├── data/
    │   ├── dto/                   # TodoDto, TodoRequest (@JsonSerializable)
    │   ├── model/                 # TodoModel (@freezed, fromDto factory)
    │   ├── data_source/           # todosRepoProvider (@riverpod functional provider)
    │   └── repo_impl/             # TodosRepoImpl
    ├── domain/
    │   └── todos_repo.dart        # abstract TodosRepo (framework-free)
    └── presentation/
        ├── controller/
        │   ├── notifier/          # TodoListNotifier (@riverpod class)
        │   └── states/            # TodoListState (freezed union)
        ├── views/                 # Route-level screens (list, add/edit)
        ├── widgets/                # Feature-scoped widgets (todo card, etc.)
        └── helpers/                # Skeleton placeholder helper
```

**Dependency rule:** Presentation → Domain ← Data. Screens and notifiers never talk to Dio directly — only through the abstract `TodosRepo` contract.

## Error Handling Details

`NetworkErrorHandler.handleError(DioException)` maps Dio failures into a `NetworkException` freezed union (17 cases, including `noInternetConnection`, `requestTimeout`, `internalServerError`, `notFound`, etc.). `getNetworkErrorMessage()` turns that into an English, user-facing string rendered by `CustomErrorWidget`.

Offline detection has no separate connectivity service — a `SocketException` thrown by Dio is caught and mapped to `NetworkException.noInternetConnection`, surfaced with a retry button.

## Running the Project

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Re-run `build_runner` any time a `@freezed`, `@riverpod`, or `@JsonSerializable` annotated file is added or changed.

## Git / Commit Style

Conventional Commits with a layer scope, committed granularly:

```text
feat(model): add TodoModel with fromDto factory
feat(repo): implement TodosRepo
feat(data-source): implement todos data source
feat(notifier): implement TodoListNotifier
feat(state): create TodoListState
feat(ui): redesign todo list card
feat(repo): add pagination support to TodosRepo
fix(i18n): translate todos messages to English
test(networking): verify offline error path
```

## Notes / Known Deviations

- `BaseApiClient` is a plain singleton-by-provider class (no `injectable`/`@singleton` in this project's toolchain).
- Riverpod v3 code generation strips the `Notifier` suffix from the generated provider name — `TodoListNotifier` generates `todoListProvider`, not `todoListNotifierProvider`.
- `json_annotation` is pinned to the `4.9.x` line to keep `json_serializable` compatible with `riverpod_generator` on the Dart SDK used here.

## Possible Next Steps

- Unit tests for `TodosRepoImpl` and `TodoListNotifier` (mocking `BaseApiClient`)
- Local persistence (Hive/SQLite) layered under the existing repository so todos survive app restarts
- Dark theme polish beyond the base `light`/`dark` theming setup already in place
