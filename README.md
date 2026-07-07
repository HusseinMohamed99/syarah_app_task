# Todo App

A Flutter todo application built with a Clean-Architecture-lite, feature-first
structure. It uses Riverpod v3 (code generation) for state management, a single
`Dio` instance behind a shared `BaseApiClient` for networking, `go_router` for
typed navigation, and a small shared design-system core (`ColorManager`,
`context.*` text-style extensions, and `flutter_screenutil`). The app is light
mode only.

## Tech Stack

| Layer            | Choice                                                                          |
| ---------------- | ------------------------------------------------------------------------------- |
| State management | Riverpod v3 with code generation (`riverpod_annotation` / `riverpod_generator`) |
| Networking       | Single shared `Dio` instance behind `BaseApiClient`                             |
| Models           | `@JsonSerializable` DTOs + `@freezed` domain models                             |
| Routing          | `go_router` + `go_router_builder` (typed routes)                                |
| Theming          | `ColorManager` + `context.*` text-style extensions + `flutter_screenutil`       |
| Loading UI       | `skeletonizer` shimmer placeholders                                             |
| Error handling   | `ApiResult<T>` (freezed `Success`/`Failure` union) + `NetworkException`         |

## State Management

Riverpod v3 is used with code generation throughout:

- `TodoListNotifier` (`@riverpod class`) holds all todo-list logic and exposes a
  generated `todoListProvider`. It builds a `TodoListState`, loads the first page
  in `build()`, and exposes `refresh`, `loadMore`, `search`, `addTodo`,
  `updateTodo`, `toggleCompleted`, `deleteTodo`, and `retry`.
- `TodoListState` is a `@freezed` immutable state class with a `status` enum
  (`initial` / `loading` / `loaded` / `error`), the todo list, `searchQuery`,
  pagination fields (`currentPage`, `hasMore`, `isLoadingMore`), an optional
  `NetworkException error`, and computed getters (`filteredTodos`, `isEmpty`,
  `hasNoSearchResults`, `isSearching`).
- `todosRepoProvider` (`@riverpod` functional provider in the data layer) wires
  `TodosRepoImpl` to the `baseApiClientProvider`.

Mutations update local state optimistically after a successful response rather
than refetching (see Data Source).

## Data Source

[`https://jsonplaceholder.typicode.com/todos`](https://jsonplaceholder.typicode.com/todos)
— a fake REST API. `GET` requests return real data; `POST` / `PUT` / `DELETE`
return success responses (200/201) but do **not** persist anything server-side.
The app updates local state after a successful mutation instead of refetching.

## Networking

- A single `Dio` is created in `dioProvider` with the base URL, a 120s
  connect/receive/send timeout, and `Accept: application/json`. Two interceptors
  are attached: `RetryInterceptor` (retries timeout/connection errors up to twice)
  and `LoggingInterceptor` (request/response/error logging via `dart:developer`).
- `BaseApiClient` wraps that `Dio` and exposes `getRaw` / `postRaw` / `putRaw` /
  `deleteRaw`. Every call is run through a private `_guard` that returns an
  `ApiResult<T>` — `ApiResult.success(data)` or `ApiResult.failure(NetworkException)`.
- Pagination is done with query params: `getTodos({page, limit})` sends
  `GET /todos?_page=<page>&_limit=<limit>` (default limit `20`). `hasMore` is
  derived from whether a page came back full.

## Features

### Todo List

- Paginated fetch (`GET /todos?_page=&_limit=`) with infinite scroll — the
  next page loads as the list nears the bottom.
- Loading, empty, error, and loaded states, each with its own visual treatment.
- Pull-to-refresh (`RefreshIndicator`, resets back to page 1).
- Client-side search/filter by title across all currently loaded todos.
- Custom card design for each todo (not a stock `ListTile`): an accent side-bar,
  an animated completion check, a status badge (Done/Pending), a user tag, and
  swipe-to-delete via `Dismissible`.

### Add / Edit Todo

- Add a new todo.
- Edit an existing todo.
- Delete a todo (swipe on the list, or the trash action / confirm dialog on the
  edit screen).
- A single animated form screen serves both add and edit, with title validation
  and a completed toggle.

### Error Handling

- No internet connection.
- Request timeout.
- Server error (4xx / 5xx), each mapped to its own case.

### Code Style

The codebase under `lib/core/`, `lib/features/`, and `test/` is comment-free by
convention — comments were intentionally stripped. The only exceptions are
generated files (`.g.dart` / `.freezed.dart`, left untouched) and
`// ignore:` / `// ignore_for_file:` lint-suppression directives, which are kept.

### Language

All user-facing strings are in English.

## Project Structure

```text
lib/
├── main.dart                       # ProviderScope + MaterialApp.router (light theme only)
├── core/                           # Cross-cutting infrastructure
│   ├── config/                     # AppConstants (base URL, endpoint, timeout, page limit)
│   ├── network/                    # BaseApiClient, dioProvider, baseApiClientProvider,
│   │   │                           #   ApiResult, NetworkException, NetworkErrorHandler,
│   │   │                           #   BaseResponse
│   │   └── interceptors/           # RetryInterceptor, LoggingInterceptor
│   ├── routing/                    # AppPaths, typed go_router routes, appRouterProvider
│   ├── navigation/                 # RouteNavigationExtension (safePush guard)
│   ├── theming/
│   │   ├── colorManager/           # ColorManager palette
│   │   └── themingManager/         # buildLightTheme, buildAppTextTheme
│   ├── helpers/
│   │   ├── dimensions/             # k*-prefixed spacing/sizing constants
│   │   ├── extensions/             # text styles, widget padding, snack bar extensions
│   │   └── functions/              # getNetworkErrorMessage()
│   └── widgets/
│       ├── appbar/                 # basicAppBar, BackButtonWidget
│       ├── buttons/                # CustomButton
│       ├── errors/                 # CustomErrorWidget
│       ├── inputs/                 # CustomTextFormField
│       ├── loading/                # AdaptiveLoadingIndicator, AppSkeleton
│       └── missing_data/           # MissingDataView
│
└── features/todos/
    ├── data/
    │   ├── dto/                    # TodoDto, TodoRequest (@JsonSerializable)
    │   ├── model/                  # TodoModel (@freezed, fromDto factory)
    │   ├── data_source/            # todosRepoProvider (@riverpod functional provider)
    │   └── repo_impl/              # TodosRepoImpl
    ├── domain/
    │   └── repo/                   # abstract TodosRepo (framework-free contract)
    └── presentation/
        ├── controller/
        │   ├── notifier/           # TodoListNotifier (@riverpod class)
        │   └── states/             # TodoListState (freezed)
        ├── views/                  # Route-level screens (list, add/edit)
        ├── widgets/                # TodoListItem, TodoSearchField
        └── helpers/                # TodoListSkeleton placeholder
```

**Dependency rule:** Presentation → Domain ← Data. Screens and notifiers never
talk to Dio directly — only through the abstract `TodosRepo` contract.

## Theming

Light mode only — a single fixed theme with no system-brightness switching.
`MaterialApp.router` sets `theme: buildLightTheme()` and nothing else. The
Material 3 `ColorScheme.light` is driven by `ColorManager`:

- **Primary** deep green (`#1E6F5C`) with a warm amber **secondary** (`#F2A65A`).
- **Neutrals**: light grey background (`#F7F8FA`) over white surfaces (`#FFFFFF`),
  near-black primary text (`#1A1C1E`) and grey secondary text (`#6B7280`).
- **Semantic**: error (`#D64545`), success (`#2E7D32`), warning (`#ED8F03`),
  info (`#2F6FED`).
- **Support**: border, disabled, and shimmer tokens used by the skeleton loader.

Typography is a single `buildAppTextTheme` scale surfaced through `context.*`
getters (e.g. `context.headingH5`, `context.bodyRegular`).

## Error Handling Details

`NetworkErrorHandler.handleError(DioException)` maps Dio failures into a
`NetworkException` freezed union (17 cases, including `noInternetConnection`,
`requestTimeout`, `internalServerError`, `serviceUnavailable`, `notFound`, etc.).
`getNetworkErrorMessage()` turns that into an English, user-facing string
rendered by `CustomErrorWidget` with a retry button.

Distinct cases:

- **No internet** — a `SocketException` (or Dio `connectionError`) is caught and
  mapped to `NetworkException.noInternetConnection`.
- **Timeout** — `connectionTimeout` / `receiveTimeout` / `sendTimeout` map to
  `requestTimeout` / `sendTimeout`.
- **Server error** — `badResponse` is mapped by status code (400/401/403/404/409/
  423/500/503, with a catch-all `unexpectedError`).

There is no separate connectivity service. Offline behavior is verified in tests:

- `test/offline_error_test.dart` points a real `Dio` at an unreachable host
  (`http://nonexistent.invalid`) and asserts the result is
  `ApiResult.failure(NetworkException.noInternetConnection())`, plus unit checks
  for the `connectionError` and `SocketException` mappings.
- `test/offline_ui_test.dart` overrides `todosRepoProvider` with an always-offline
  repo and asserts the UI renders `CustomErrorWidget` with the English
  "No internet connection" message.
- `test/todo_model_test.dart` covers `TodoModel.fromDto` mapping and defaults.

## Running the Project

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Re-run `build_runner` any time a `@freezed`, `@riverpod`, or `@JsonSerializable`
annotated file is added or changed. Run the tests with `flutter test`.

## Git / Commit Style

Conventional Commits with a layer scope, committed granularly. Types used across
the history include `feat`, `fix`, `test`, `refactor`, `chore`, and `docs`:

```text
feat(model): add TodoModel with fromDto factory
feat(repo): implement TodosRepo
feat(notifier): implement TodoListNotifier
feat(state): create TodoListState
feat(ui): redesign todo card, empty/error states and form
feat(repo): add pagination support with infinite scroll
fix(i18n): translate todos messages to English
test(networking): verify offline error path
refactor(theming): light theme only
chore: remove comments from core, features, and test files
docs: update README with project overview and error handling details
```

## Notes / Known Deviations

- jsonplaceholder does not persist `POST` / `PUT` / `DELETE`, so added, edited,
  and deleted todos live in local session state only and reset on app restart.
- `BaseApiClient` is a plain provider-scoped class (no `injectable`/`@singleton`
  in this project's toolchain).
- Riverpod v3 code generation strips the `Notifier` suffix from the generated
  provider name — `TodoListNotifier` generates `todoListProvider`, not
  `todoListNotifierProvider`.
- `json_annotation` is pinned to the `4.9.x` line to keep `json_serializable`
  compatible with `riverpod_generator` on the Dart SDK used here.

## Possible Next Steps

- Local persistence (Hive/SQLite) layered under the existing repository so todos
  survive app restarts.
- Notifier-level tests for `TodoListNotifier` (pagination, search, mutations) to
  complement the existing mapping and offline tests.
- Server-backed search/filtering if the API supported it.
