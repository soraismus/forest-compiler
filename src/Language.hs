{-# LANGUAGE DeriveGeneric #-}

module Language
  ( NonEmptyString(..)
  , OperatorExpr(..)
  , Ident(..)
  , Expression(..)
  , Declaration(..)
  , Annotation(..)
  , AnnotationType(..)
  , Module(..)
  , Constructor(..)
  , TopLevel(..)
  , ADT(..)
  , s
  , idToString
  , neToString
  ) where

import Data.List.NonEmpty (NonEmpty)
import qualified Data.List.NonEmpty as NE
import qualified Generics.Deriving as G

newtype Module =
  Module [TopLevel]
  deriving (Show, Eq, G.Generic)

data TopLevel
  = Function Declaration
  | DataType ADT
  deriving (Show, Eq, G.Generic)

data ADT =
  ADT Ident
      [Ident]
      (NonEmpty Constructor)
  deriving (Show, Eq, G.Generic)

data Declaration =
  Declaration (Maybe Annotation)
              Ident
              [Ident]
              Expression
  deriving (Show, Eq, G.Generic)

data Annotation =
  Annotation Ident
             (NonEmpty AnnotationType)
  deriving (Show, Eq, G.Generic)

data AnnotationType
  = Concrete Ident
  | Parenthesized (NonEmpty AnnotationType)
  | TypeApplication AnnotationType AnnotationType
  deriving (Show, Eq, G.Generic)

data Expression
  = Identifier Ident
  | Number Int
  | Infix OperatorExpr
          Expression
          Expression
  | Apply Expression
          Expression
  | Case Expression
         (NonEmpty (Expression, Expression))
  | Let (NonEmpty Declaration)
        Expression
  | BetweenParens Expression
  | String' String
  deriving (Show, Eq, G.Generic)

data Constructor =
  Constructor Ident
              [Ident]
  deriving (Show, Eq, G.Generic)

data OperatorExpr
  = Add
  | Subtract
  | Divide
  | Multiply
  | StringAdd
  deriving (Show, Eq, G.Generic)

newtype Ident =
  Ident NonEmptyString
  deriving (Show, Eq)

newtype NonEmptyString =
  NonEmptyString (NonEmpty Char)
  deriving (Show, Eq)

s :: Ident -> String
s = idToString

idToString :: Ident -> String
idToString (Ident str) = neToString str

neToString :: NonEmptyString -> String
neToString (NonEmptyString se) = NE.toList se
