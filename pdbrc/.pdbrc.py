# https://stackoverflow.com/questions/65816273/enter-sticky-mode-by-default-with-ipdb
import pdb
class Config(pdb.DefaultConfig):
    sticky_by_default = True
