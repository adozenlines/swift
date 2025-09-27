// RUN: %target-typecheck-verify-swift

func h(_ xs: [String]) {
  _ = xs.first { s in
    s.count > 0 && s.bogus == "x" // expected-error {{value of type 'String' has no member 'bogus'}}
  } // expected-note {{did you mean 'first(where:)'?}}
}
