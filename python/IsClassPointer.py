import gdb

class IsClassPointer (gdb.Function):
  """Given an expression checks if it is a variable of type class* or not."""

  def __init__ (self):
    super (IsClassPointer, self).__init__ ("IsClassPointer")

  def invoke (self, input):
      type_in_str = str(input.type)
      if "class" in type_in_str and "*" in type_in_str:
          return True

      return False
