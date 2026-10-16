/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib

/-!
# The Gallai–Hasse–Roy–Vitaver theorem

An orientation of a simple graph `G` is a relation `o` such that every edge `uv` of `G` is
oriented in at least one direction (`o u v ∨ o v u`) and every arc is an edge of `G`. A directed
path with `m` vertices is an injective map `f : Fin m → V` with an arc from `f i` to `f (i + 1)`
for all consecutive indices.

* `GallaiRoyTheorem.colorable_of_orientation`: **Gallai (1968), Hasse (1965), Roy (1967),
  Vitaver (1962).** If some orientation of `G` has no directed path with more than `k` vertices,
  then `G` is `k`-colourable.
* `GallaiRoyTheorem.exists_orientation_of_colorable`: conversely, a `k`-colourable graph has an
  (acyclic) orientation without directed paths on more than `k` vertices. Together: the
  chromatic number is the minimum, over orientations, of the number of vertices of a longest
  directed path.

The Mathlib definitions used in these statements are reproduced verbatim, with file and line at the
pinned Mathlib revision, in `MATHLIB_DEFINITIONS.md` at the root of this repository.
-/

@[expose] public section

open SimpleGraph

namespace GallaiRoyTheorem

variable {V : Type*}

/-- `o` is an orientation of `G`: every edge is oriented in at least one direction and every arc
is an edge. -/
def IsOrientation (G : SimpleGraph V) (o : V → V → Prop) : Prop :=
  (∀ u v, G.Adj u v → o u v ∨ o v u) ∧ ∀ u v, o u v → G.Adj u v

/-- `f` is a directed path of `o` with `m` vertices. -/
def IsDirectedPath (o : V → V → Prop) {m : ℕ} (f : Fin m → V) : Prop :=
  Function.Injective f ∧ ∀ (i : ℕ) (h : i + 1 < m), o (f ⟨i, by omega⟩) (f ⟨i + 1, h⟩)

/-- **Gallai–Hasse–Roy–Vitaver.** If an orientation of a finite graph has no directed path on more
than `k` vertices, the graph is `k`-colourable. -/
theorem colorable_of_orientation [Finite V] (G : SimpleGraph V) (o : V → V → Prop)
    (ho : IsOrientation G o) (k : ℕ)
    (hk : ∀ (m : ℕ) (f : Fin m → V), IsDirectedPath o f → m ≤ k) : G.Colorable k := by
  sorry

/-- Conversely, a `k`-colourable graph has an orientation without directed paths on more than `k`
vertices (orient every edge towards the larger colour). -/
theorem exists_orientation_of_colorable (G : SimpleGraph V) (k : ℕ) (h : G.Colorable k) :
    ∃ o : V → V → Prop, IsOrientation G o ∧
      ∀ (m : ℕ) (f : Fin m → V), IsDirectedPath o f → m ≤ k := by
  sorry

end GallaiRoyTheorem
