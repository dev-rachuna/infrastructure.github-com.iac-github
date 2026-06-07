# <img src="images/opentofu.png" alt="opentofu" height="30"/> iac-github

::include{file=.gitlab/badges.md}

Projekt OpenTofu do zarządzania repozytoriami w organizacji GitHub `dev-rachuna`.

Organizacja została rozpoznana z GitHub API jako `dev-rachuna`. Nazwa `dev.rachuna` nie jest poprawnym slugiem organizacji na github.com.

---

## Uwierzytelnianie

Nie zapisuj tokenów GitHub w repozytorium. Przed uruchomieniem OpenTofu ustaw token w zmiennej środowiskowej:

```sh
export GITHUB_TOKEN="..."
```

Provider `integrations/github` odczytuje `GITHUB_TOKEN` automatycznie.

---

## Użycie

```sh
tofu init
tofu plan
tofu apply
```

Projekt definiuje repozytoria zwrócone przez GitHub API dla organizacji `dev-rachuna`. Istniejące repozytoria są mapowane przez bloki importu, więc pierwszy `tofu apply` importuje je do state zamiast tworzyć od nowa.

---

## Dodawanie repozytorium

Do dodania nowego repozytorium do konfiguracji użyj helpera:

```sh
bin/create-repo artifacts.example "Opis repozytorium"
```

Repozytorium prywatne:

```sh
bin/create-repo --private artifacts.example "Opis repozytorium"
```

Inna gałąź domyślna:

```sh
bin/create-repo --default-branch develop artifacts.example "Opis repozytorium"
```

Skrypt tworzy plik `repository_*.tf.json` i dopisuje repozytorium do `locals.tf.json`. Nie dodaje bloku `import`, bo nowe repozytorium ma zostać utworzone przez `tofu apply`.

---

## Zarządzane obiekty

- `github_repository.repositories` tworzy i zarządza repozytoriami z `local.repositories`.
- `github_branch_default.repositories` śledzi repozytoria, których gałąź domyślna nie jest `main`.
- `locals.tf.json` agreguje repozytoria z plików `repository_*.tf.json`.

---

::include{file=.gitlab/footer.md}
