# Laboratorio 6 · Muro

Punto de partida del **Laboratorio 6**: un muro al estilo de Twitter sobre Supabase. La guía completa está en el visor del curso, en la lección *Laboratorio 6 · Muro*.

## Cómo correrlo

1. Pon la `Project URL` y la `publishable key` de **tu** proyecto de Supabase en `lib/main.dart`.
2. Crea las tablas `posts` y `likes`, como dicen *Escribir en la base de datos* y el laboratorio. Lo más fácil es copiar aquí la carpeta `supabase/` de tu proyecto del Laboratorio 5, que ya trae tu `link` y tu migración de `profiles`, y agregar las dos migraciones nuevas.
3. Corre la app:

```bash
flutter pub get
flutter run
```

## Qué ya funciona

- **Registro e inicio de sesión.** Es el Laboratorio 5 resuelto, con Clean Architecture y Bloc (estado único con `copyWith`), en `features/auth`, `features/login` y `features/register`.
- **Toda la interfaz del muro.** `HomeScreen` hospeda `FeedPage` y `ProfilePage` con un `BottomNavigationBar`; el botón flotante abre `ComposeScreen`. Cada botón ya lanza su evento.
- **Los estados.** `FeedState` y `ComposeState` ya están modelados, con su `copyWith`.
- **Los eventos llegan.** Cada método `on` vacío solo imprime el evento que recibió, así ves en la consola que la interfaz ya está conectada a su Bloc:

```text
FeedBloc recibió FeedStarted()
FeedBloc recibió FeedLikeToggled(Post(9b1e…, @ana.dev, likes: 0))
ComposeBloc recibió ComposeSubmitted('Hola muro')
```

## Qué te toca

Los eventos llegan, pero nadie los atiende: los métodos `on` de `FeedBloc` y `ComposeBloc` solo imprimen, y las capas de `features/posts` existen pero no tienen nada adentro ni se conectan entre sí. Tu trabajo es decidir qué va en cada una:

- `posts/domain/repository/post_repository.dart`: el contrato. ¿Qué operaciones necesita el muro?
- `posts/domain/usecases/`: un caso de uso por acción. Validar el texto de un post le toca a uno de ellos.
- `posts/data/source/supabase_post_data_source.dart`: el único archivo que usa `_client.from(...)`.
- `posts/data/repository/post_repository_impl.dart`: cumple el contrato delegando en el data source.
- `home/ui/bloc/feed_bloc.dart` y `compose/ui/bloc/compose_bloc.dart`: reciben sus casos de uso por constructor, y en cada `on` reemplazas el `debugPrint` por la lógica que emite estados.
- `main.dart`: arma la cadena completa en las rutas `/home` y `/compose`.

Mientras trabajas, mira la consola: si todavía ves `recibió`, ese `on` no hace nada más.

## Estructura

```text
lib/
  main.dart
  theme/app_theme.dart
  components/            PrimaryButton y ErrorMessage
  features/
    auth/                Laboratorio 5, resuelto
    login/ui/            LoginScreen y su Bloc
    register/ui/         RegisterScreen y su Bloc
    posts/
      domain/entities/post.dart        lista
      domain/repository/               vacío
      domain/usecases/                 vacíos
      data/source/                     vacío
      data/repository/                 vacío
    home/ui/
      bloc/              FeedBloc, con sus on que solo imprimen
      screens/home_screen.dart
      pages/             FeedPage y ProfilePage
      components/post_card.dart
    compose/ui/          ComposeScreen y ComposeBloc, con su on que solo imprime
```

`flutter test` comprueba que la interfaz lanza los eventos correctos.
