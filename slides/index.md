---
title: From Functional Programming to Formal Verification
description:
headingDivider: 2
transition: fade 100ms
theme: gaia
class:
  - invert
---

## <!-- fit -->From Functional Programming to Formal Verification

<!-- _class: lead invert -->

#### Haskell, Agda and Idris

Hideaki Kawai


## Contents

- Haskell
  - **Technical**
  - Social
- My work
- Formal verification

## Haskell

* Purely functional
* Strong type system

## Purely functional

```
succ :: Int -> Int
succ x = x + 1
```

No side-effect.

* Return value - always the same with the same argument.
* Evaluation timing - does not matter.
* **Referential transparancy**

## Side-effects

Real World is full of **side-effects**.

* Interacting Input/Output.
  - `getLine`: varies every time?
  - `putStr`: order?
* Generating random numbers.
  - `rand`: random?

## Real World

```hs
getLine :: RealWorld -> (RealWorld, String)
putStr :: (RealWorld, String) -> RealWorld
```

## Real World

```hs
getLine :: RealWorld -> (RealWorld, String)
putStr :: (RealWorld, String) -> RealWorld
```

```hs
echo :: RealWorld -> RealWorld
echo rw0 =
  let (rw1, str) = getLine rw0
      rw2 = putStr (rw1, str)
  in rw2
```

* Not human-friendly
* Error prone

## IO Monad

```hs
getLine :: IO String
putStr :: String -> IO ()
```

```hs
echo :: IO ()
echo = getLine >>= putStr
```

## Under the hood

```hs
class Functor m where
  fmap :: (a -> b) -> m a -> m b

class Functor m => Applicative m where
  pure :: m a
  <*> :: m (a -> b) -> m a -> m b

class Applicative m => Monad m where
  >>= :: m a -> (a -> m b) -> m b
```

* **Higher-kinded polymorphism**

##

<style scoped>
  img:nth-of-type(1) {
      position: absolute;
      top: 10%;
      left: 27.5%;
      width: 45%;
      transform: rotate(2deg);
      filter: drop-shadow(0 10px 8px rgb(0 0 0 / 0.04)) drop-shadow(0 4px 3px rgb(0 0 0 / 0.1));
  }
</style>

![center 50%](./assets/Spj1992.png)


## Summary - Haskell

* Purely functional
  * Side-effects are not allowed outside of IO
* Strong type system
  * Type signature tells a lot
  * `Monad` - Human-friendly

## Comparison with other languages

* Scala, Rust
  - supports higher-kinded polymorphism
  - not purely functional
* PureScript, Agda, Idris
  - Haskell-like languages

## Contents

- Haskell
  - Technical
  - **Social**
- My work
- Formal verification

## ICFP

![right bg 95%](./assets/icfp2023.png)

### <!-- fit -->[International Conference on Functional Programming](https://icfp23.sigplan.org/series/icfp)

- Annual conference
  - 2019 at Berlin
  - 2016 at Nara, Japan
- August/September
- 5 - 7 days
- Not only Haskell

## Who uses Haskell?

* Tech giants
  - Google, Facebook, Microsoft, ...
* Universities, research institute
  - Glasgow, Chalmers, Utrecht, Penn, ...
  - Jane Street, Galois, Inria, ...
* Consulting
  - Tweag, Well-Typed, FP Complete, Obsidian systems, ...

## For what?

* Field
  - Finance, Telecommunications, Defense, Blockchain, ...

## Human resource

* Functional programmers
  - Demand < Supply
  - Haskell tax
* Quantum computing
  - Demand > Supply

## Contents

- Haskell
  - Technical
  - Social
- **My work**
- Formal verification

## Brief history of my Haskell journey

- 2004 Start software engineering
- 2015 Start Haskell
  - 2016 ICFP
- 2018 Lead a team of Haskellers
  - 2 - 6 Haskell engineers

## Wakame

<style scoped>
  img:nth-of-type(1) {
      position: absolute;
      top: 20%;
      left: 1rem;
      width: 45%;
  }
  img:nth-of-type(2) {
      position: absolute;
      top: 10%;
      right: 1rem;
      width: 45%;
      transform: rotate(2deg);
      filter: drop-shadow(0 10px 8px rgb(0 0 0 / 0.04)) drop-shadow(0 4px 3px rgb(0 0 0 / 0.1));
  }
  img:nth-of-type(3) {
      position: absolute;
      top: 40%;
      right: 1rem;
      width: 45%;
      transform: rotate(-3deg);
      filter: drop-shadow(0 10px 8px rgb(0 0 0 / 0.04)) drop-shadow(0 4px 3px rgb(0 0 0 / 0.1));
  }
</style>

![](./assets/wakame.png)
![](./assets/Mitchell1991.png)
![](./assets/Edsko2014.png)

## Contents

- Haskell
  - Technical
  - Social
- My work
- **Formal verification**

## Curry-Howard Correspondence

<style scoped>
  table {
      margin-left: auto;
      margin-right: auto;
  }
</style>

| Logic       | Programming |
| :---:       | :---------: |
| Proposition | Type        |
| Proof       | Term        |


## Curry-Howard Correspondence

<style scoped>
  table {
      margin-left: auto;
      margin-right: auto;
  }
</style>

| Logic       | Programming |
| :---:       | :---------: |
| Conjunction | Product     |
| Disjunction | Sum         |
| True        | Unit        |
| False       | Empty       |
| Implication | Function    |

Negation, universals, existentials, ...

## Natural Number

```agda
data ℕ : Set where
  zero : ℕ
  suc : ℕ → ℕ

_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)
```

## Prove associativity

<style scoped>
  section {
      columns: 2;
  }
</style>

```agda
data ℕ : Set where
  zero : ℕ
  suc : ℕ → ℕ

_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)
```

```
+-assoc : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc zero n p =
  begin
    (zero + n) + p
  ≡⟨⟩
    n + p
  ≡⟨⟩
    zero + (n + p)
  ∎
+-assoc (suc m) n p =
  begin
    (suc m + n) + p
  ≡⟨⟩
    suc (m + n) + p
  ≡⟨⟩
    suc ((m + n) + p)
  ≡⟨ cong suc (+-assoc m n p) ⟩
    suc (m + (n + p))
  ≡⟨⟩
   suc m + (n + p)
  ∎
```

## Formal Verification Tools

- [Coq](https://coq.inria.fr/)
  - Most popular, extra layer of tactics
- [Agda](https://wiki.portal.chalmers.se/agda/pmwiki.php)
  - Haskell like, no intermediate layer
- [Lean](https://leanprover.github.io/theorem_proving_in_lean/index.html)
  - by Microsoft, newer
- [Isabelle](https://isabelle.in.tum.de/index.html)
  - by University of Cambridge, Technische Universitat Munchen

## Papers

- Towards a practical programming language based on dependent type theory, Ulf Norell, 2007
- Towards a formally verified functional quantum programming language, Alexander Green, 2010
- Formally verified quantum programming, Robert Rand, 2018

## Idris

- Haskell like syntax
- More powerful type system
  - Dependent types
  - Linear types
- Free from legacy heritage
  - scheme

##

<style scoped>
  h3 {
      text-align: center;
      margin-top: 20%;
  }
</style>

### Thank you
