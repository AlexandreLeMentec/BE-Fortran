import numpy as np
from affichage import affichage
import os

class application:
    def __init__(self):
        self.affichage = affichage()
        self.var = [] # 0:L, 1:D, 2:C0, 3:xd, 4:xf, 5:N, 6:Dt, 7:Nt
        self.lines = [] # line storing vector
        self.t
        self.move = 0 # 0:test, 1:D, 2:N, 3:Dt, 4:Nt, 5:T, 6:t
  
    def run(self):
        os.system("Main.exe")
        self.affichage.read_data_results()
        self.affichage.plot()
    
    def read_data(self):
        count = 0
        with open("donnees.dat", "r") as my_file:
            for line in my_file:
                if count != 0 and count != 6 and count != 7:
                    self.var[count] = float(line.split()[0])
            count += 1
    
    def get_const(self):
        print("quelle valeur voulez vous faire varier ?")
        print("1: D, 2: N, 3: Dt, 4: Nt, 5: t")
        self.move = int(input())
    
    def update_data(self):
        affichage.N = self.var[5]
        affichage.DT = self.var[6]
        affichage.NT = self.var[7]
        affichage.t = self.t
        


be_fortran = application()
be_fortran.run()