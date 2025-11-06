# debug_min.py
from mpi4py import MPI
from dolfinx.mesh import create_unit_square
from dolfinx.fem import (functionspace,form)
import ufl
import basix
import sys

mesh = create_unit_square(MPI.COMM_WORLD, 4, 4)     # very coarse
element  = basix.ufl.element("Lagrange", mesh.basix_cell(), 1)
V = functionspace(mesh, element)
print("Created V; global dofs:", V.dofmap.index_map.size_global)
# Try a trivial bilinear form and assemble
from ufl import TrialFunction, TestFunction, inner, grad
u = TrialFunction(V); v = TestFunction(V)
a = inner(grad(u), grad(v))*ufl.dx
from dolfinx.fem.petsc import assemble_matrix, assemble_vector
A = assemble_matrix(form(a))  # small
A.assemble()
print("Assembled tiny matrix OK")
