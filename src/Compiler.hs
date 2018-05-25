module Compiler
  ( compile
  , format
  , formatJS
  ) where

import HaskellSyntax
import qualified JavaScriptSyntax as JS
import WASM

compile :: String -> Either ParseError' String
compile s = printWasm . forestModuleToWasm <$> parseModule s

format :: String -> Either ParseError' String
format s = printModule <$> parseModule s

formatJS :: String -> Either ParseError' String
formatJS s = JS.printModule <$> parseModule s
