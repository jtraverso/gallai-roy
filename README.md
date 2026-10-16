# The Gallai–Hasse–Roy–Vitaver theorem in Lean 4

Author and maintainer: **Juan Pablo Traverso Gianini**. Licence: Apache-2.0 (see `LICENSE`).

**Theorem (Gallai 1968, Hasse 1965, Roy 1967, Vitaver 1962).** If some orientation of a finite
graph `G` has no directed path on more than `k` vertices, then `G` is `k`-colourable
(`GallaiRoyTheorem.colorable_of_orientation`).

**Converse.** A `k`-colourable graph has an orientation without directed paths on more than `k`
vertices (`GallaiRoyTheorem.exists_orientation_of_colorable`). Together, the chromatic number is
the minimum, over all orientations, of the number of vertices of a longest directed path.

Two notions are defined in the Challenge:
- **orientation:** a relation `o` that orients every edge of `G` in at least one direction and
  whose arcs are edges of `G`;
- **directed path with `m` vertices:** an injective map `Fin m → V` with an arc between
  consecutive vertices.

## Files

- [`Challenge.lean`](Challenge.lean): the audited statements. It imports only Mathlib.
- [`Solution.lean`](Solution.lean) and
  [`GallaiRoyLib/GallaiRoy.lean`](GallaiRoyLib/GallaiRoy.lean): the proofs.
- [`comparator.json`](comparator.json): the theorems that are compared.
- [`MATHLIB_DEFINITIONS.md`](MATHLIB_DEFINITIONS.md): verbatim copies of the Mathlib definitions
  used.
- [`formalization.yaml`](formalization.yaml): provenance, sources and process.

## How the proof goes

* **Main theorem.**
  1. Choose a maximal acyclic sub-relation `D` of the orientation.
  2. Colour each vertex by the length of a longest `D`-path starting at it. This is at most
     `k − 1`, since `D`-paths are directed paths of `o`.
  3. Consider an edge `u → v` of `o`. If the arc is in `D`, the colour of `u` is larger. If it is
     not, maximality of `D` gives a `D`-path from `v` to `u`, so the colour of `v` is larger.
* **Converse.** Orient each edge towards the larger colour. Colours then strictly increase along
  directed paths.

## Sources

* B. Roy, *Nombre chromatique et plus longs chemins d'un graphe*, Rev. Française Informat.
  Recherche Opérationnelle 1 (1967) 129–132, doi:10.1051/m2an/1967010501291.
* M. Hasse, *Zur algebraischen Begründung der Graphentheorie. I*, Math. Nachr. 28 (1965)
  275–290, doi:10.1002/mana.19650280503.
* T. Gallai, *On directed paths and circuits*, in: Theory of Graphs (Proc. Colloq. Tihany, 1966),
  Academic Press (1968) 115–118.
* L. M. Vitaver, *Determination of minimal coloring of vertices of a graph by means of Boolean
  powers of the incidence matrix*, Dokl. Akad. Nauk SSSR 147 (1962) 758–759.

## Authorship and use of AI

The author chose the result. The statements and proof plan were written with Claude in Claude
Code. Harmonic's Aristotle produced the proofs, which were audited and rebuilt locally. Lean
checks everything mechanically. See `formalization.yaml`.

## Building

Lean `v4.35.0-rc3`, Mathlib `c55e6e786f49471c72fbddbec5415808896aec1e`:

```bash
lake exe cache get
lake build
```
