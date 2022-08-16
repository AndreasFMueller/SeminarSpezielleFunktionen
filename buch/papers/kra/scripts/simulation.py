import sympy as sp


class Simulation:
    def __init__(self):
        self.k_1, self.k_2, self.k_c = sp.symbols("k_1 k_2 k_c")
        self.m_1, self.m_2 = sp.symbols("m_1 m_2")
        self.t = sp.symbols("t")
        K = sp.Matrix(
            [[-(self.k_1 + self.k_c), self.k_c], [self.k_c, -(self.k_2 + self.k_c)]]
        )
        M = sp.Matrix([[1 / self.m_1, 0], [0, 1 / self.m_2]])
        A = M * K

        self.eigenvecs = []
        self.eigenvals = []
        for ev, mult, vecs in A.eigenvects():
            self.eigenvecs.append(sp.Matrix(vecs))
            self.eigenvals.extend([ev] * mult)

    def __call__(self, t, x_0, k_1, k_c, k_2, m_1, m_2):
        params = {
            self.k_1: k_1,
            self.k_c: k_c,
            self.k_2: k_2,
            self.m_1: m_1,
            self.m_2: m_2,
        }
        x_0 = sp.Matrix(x_0)
        eig_mat = sp.Matrix.hstack(*self.eigenvecs).subs(params)
        g = eig_mat.inv() * x_0
        L = sp.Matrix(
            [
                g[0] * sp.cos(self.eigenvals[0].subs(params) * self.t),
                g[1] * sp.cos(self.eigenvals[1].subs(params) * self.t),
            ]
        )
        x = eig_mat * L
        f = sp.lambdify(self.t, x, "numpy")
        return f(t).squeeze()
