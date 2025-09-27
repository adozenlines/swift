// RUN: %target-typecheck-verify-swift

// Reproducer: prefer closure-body error over "called non-function" on `.first {}`.
func demo(ptr: UnsafeRawPointer) {
  let regions: [UnsafeRawBufferPointer] = []
  _ = regions.first { region in
    // bogus member access should be the primary error:
    UInt(bitPattern: ptr) <
      (UInt(bitPattern: region.baseAddress!) + UInt(region.bogusProperty))
      // expected-error@-1 {{value of type 'UnsafeRawBufferPointer' has no member 'bogusProperty'}}
      // expected-note@-3 {{while matching trailing closure to 'first(where:)'}}
  }
}

// Control: if no matching callable exists, we keep the non-function error.
struct HasFirstOnly {
  var first: Int
}
func controlNoCallable() {
  let s = HasFirstOnly(first: 1)
  _ = s.first { _ in true }
  // expected-error@-1 {{cannot call value of non-function type 'Int'}}
}

// Sanity check: labeled form typechecks fine.
func okLabeled(regions: [Int]) {
  _ = regions.first(where: { $0 > 0 })
}
