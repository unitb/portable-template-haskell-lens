{-# LANGUAGE CPP #-}
module Language.Haskell.TH.Lens.Portable where

import Control.Lens
import Language.Haskell.TH

_InstanceD' :: Prism' Dec (Cxt, Type, [Dec])
_InstanceD' = prism' reviewer remitter
  where
#if MIN_VERSION_template_haskell(2,11,0)
      reviewer (x, y, z) = InstanceD Nothing x y z
      remitter (InstanceD _ x y z) = Just (x, y, z)
#else
      reviewer (x, y, z) = InstanceD x y z
      remitter (InstanceD x y z) = Just (x, y, z)
#endif
      remitter _ = Nothing

