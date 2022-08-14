import matplotlib.pyplot as plt
import numpy as np

primzahlfunktion = [0, 0, 0, 0]
x = [0, 1-1e-12, 1, 2-1e-12]
x_last = 1
value = 0
for i in range(2, 30, 1):
    new_value = value + 1
    for j in range(2, i, 1):
        if i % j == 0:
            new_value = value
    value = new_value
    primzahlfunktion.append(new_value)
    x_last += 1
    x.append(x_last)
    primzahlfunktion.append(new_value)
    x.append(x_last + 1 - 1e-12)


plt.rcParams.update({"pgf.texsystem": "pdflatex"})
plt.plot(x, primzahlfunktion)
plt.show()

