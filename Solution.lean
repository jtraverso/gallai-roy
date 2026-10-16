/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib
public import GallaiRoyLib.GallaiRoy

/-!
# Proofs of the statements in `Challenge.lean`

The definitions below are verbatim copies of those in `Challenge.lean`; they coincide with those
of `GallaiRoyLib/GallaiRoy.lean` (namespace `GallaiRoy`), where the theorems are proved: a maximal
acyclic sub-relation of the orientation is chosen, and every vertex is coloured by the length of a
longest directed path of it starting at that vertex; the converse orients every edge towards the
larger colour.
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
  Function.Injective f ∧ ∀ (i : ℕ) (h : i + 1 < m), o (f ⟨i, Nat.lt_of_succ_lt h⟩) (f ⟨i + 1, h⟩)

/-- **Gallai–Hasse–Roy–Vitaver.** If an orientation of a finite graph has no directed path on more
than `k` vertices, the graph is `k`-colourable. -/
theorem colorable_of_orientation [Finite V] (G : SimpleGraph V) (o : V → V → Prop)
    (ho : IsOrientation G o) (k : ℕ)
    (hk : ∀ (m : ℕ) (f : Fin m → V), IsDirectedPath o f → m ≤ k) : G.Colorable k :=
  GallaiRoy.colorable_of_orientation G o ho k hk

/-- Conversely, a `k`-colourable graph has an orientation without directed paths on more than `k`
vertices (orient every edge towards the larger colour). -/
theorem exists_orientation_of_colorable (G : SimpleGraph V) (k : ℕ) (h : G.Colorable k) :
    ∃ o : V → V → Prop, IsOrientation G o ∧
      ∀ (m : ℕ) (f : Fin m → V), IsDirectedPath o f → m ≤ k :=
  GallaiRoy.exists_orientation_of_colorable G k h

end GallaiRoyTheorem
