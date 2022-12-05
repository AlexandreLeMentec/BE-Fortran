import matplotlib.pyplot as plt
import numpy as np

class affichage:
  def __init__(self):
    self.N = 8
    self.t = 40
    self.DT = 10
    self.NT = 3000
    self.bigT = self.NT * self.DT
    self.x = np.zeros(self.N)
    self.Cexp = np.zeros(self.N)
    self.Ctheo = np.zeros(self.N)
  
  def read_data_results(self):
    line_count = 0
    char_count = 0
    with open("resultat.dat", "r") as my_file:
      for line in my_file:
        if line_count == 0:
          self.x = line.split()
        if line_count == 1+2*(self.t):
          self.Cexp = line.split()
        if line_count == 2+2*(self.t):
          self.Ctheo = line.split()
        line_count += 1
    for i in range(self.N):
      self.x[i] = float(self.x[i])
      self.Cexp[i] = float(self.Cexp[i])
      self.Ctheo[i] = float(self.Ctheo[i])

  def plot(self):
    plt.plot(self.x,self.Cexp,"--b",linewidth=1.0)
    plt.plot(self.x,self.Ctheo,"--r",linewidth=1.0)
    plt.title("Evolution de C en fonction de x à t = "+str(self.t*self.DT)+" s")
    plt.xlim(0.,300.)
    plt.ylim(0.,1.)
    plt.xlabel('x (m)',fontsize=16)
    plt.ylabel('concentration',fontsize=16)
    plt.savefig("res.png")
    print("generation de 1 image finie")
