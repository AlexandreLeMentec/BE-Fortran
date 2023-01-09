import numpy as np
import os
from tkinter import *
import matplotlib.pyplot as plt

class affichage:
  def __init__(self):
    self.N = 8
    self.t = 40
    self.DT = 10
    self.NT = 300
    self.L = 1000
    self.bigT = self.NT * self.DT
    self.x = np.zeros(self.N)
    self.Cexp = np.zeros(self.N)
    self.Ctheo = np.zeros(self.N)
  
  def read_data_results(self):
    line_count = 0
    with open("resultat.dat", "r") as my_file:
        for line in my_file:
            if line_count == 0:
                self.x = line.split()
            if line_count == (self.t+1):
                self.Cexp = line.split()
                print(self.Cexp)
            line_count += 1
        for i in range(self.N):
            self.x[i] = float(self.x[i])
            self.Cexp[i] = float(self.Cexp[i])

  def plot(self, result):
    plt.plot(self.x,result,"-b",linewidth=1.0)
    plt.title("Evolution de C en fonction de x à t = "+str(self.t*self.DT)+" s")
    plt.xlim(0.,1000.)
    plt.ylim(0.,1.)
    plt.xlabel('x (m)',fontsize=16)
    plt.ylabel('concentration',fontsize=16)
    plt.savefig("res.png")
    print("generation de 1 image finie")


class application:
    def __init__(self):
        self.affichage = affichage()
        self.var = [] # 0:L, 1:D, 2:C0, 3:xd, 4:xf, 5:N, 6:Dt, 7:Nt
        self.lines = [] # line storing vector
        self.t = 0
        self.move = 0 # 0:test, 1:D, 2:N, 3:Dt, 4:Nt, 5:T, 6:t
        self.multi_result = False
  
    def run(self):
        self.read_data()
        self.get_const()
        self.modify_data()
        self.update_data()
        print("veuillez executer Main.exe")
        input("appuyer sur une touche pour continuer")
        self.affichage.read_data_results()
        self.affichage.plot(self.affichage.Cexp)
    
    def read_data(self):
        with open("donnees.dat", "r") as my_file:
            count = 0
            for line in my_file:
                if count != 0 and count != 6 and count != 7:
                    self.var.append(line.split()[0])
                count += 1

    def modify_data(self):
        count = 0
        countuse = 0
        
        with open("donnees.dat", "r") as my_file:
            for line in my_file:
                self.lines.append(line)
                if count != 0 and count != 6 and count != 7:
                    if self.var[countuse] != line.split()[0]:
                        past_value = list(line.split()[0])
                        longline = list(line)
                        for i in range(len(past_value)):
                            longline.pop(0)
                        self.lines[count] = str(self.var[countuse])+"".join(longline)
                    countuse += 1
                count += 1
        with open("donnees.dat", "w") as my_file:
            for line in self.lines:
                my_file.write(str(line))
        
    
    def get_const(self):
        var = 0
 
        print("L=", self.var[0], ", D=", self.var[1], ", C0=", self.var[2], ", xd=", self.var[3], ", xf=", self.var[4], ", N=", self.var[5], ", Dt=", self.var[6], ", Nt=", self.var[7], ", nt=", self.t)
        print("quelle valeur voulez vous faire varier ? écrire à la suite les nombre correspondant aux valeurs")
        print("0: rien, 1: L, 2: D, 3: C0, 4: xd, 5: xf, 6: N, 7: Dt, 8: Nt, 9: nt")
        var = input()
        varlist = list(str(var))
        if '1' in varlist:
            print("float: mettre un point à la fin (ex: 100.)")
            print("nouvelle valeur de L:")
            self.var[0] = input()
        if '2' in varlist:
            print("float: mettre un point à la fin (ex: 100.)")
            print("nouvelle valeur de D:")
            self.var[1] = input()
        if '3' in varlist:
            print("float: mettre un point à la fin (ex: 100.)")
            print("nouvelle valeur de C0:")
            self.var[2] = input()
        if '4' in varlist:
            print("float: mettre un point à la fin (ex: 100.)")
            print("nouvelle valeur de xd:")
            self.var[3] = input()
        if "5" in varlist:
            print("float: mettre un point à la fin (ex: 100.)")
            print("nouvelle valeur de xf:")
            self.var[4] = input()
        if "6" in varlist:
            print("int: pas de virgule")
            print("nouvelle valeur de N:")
            self.var[5] = input()
        if "7" in varlist:
            print("int: pas de virgule")
            print("nouvelle valeur de Dt:")
            self.var[6] = input()
        if "8" in varlist:
            print("int: pas de virgule")
            print("nouvelle valeur de Nt:")
            self.var[7] = input()
        if "9" in varlist:
            print("int: pas de virgule")
            print("nouvelle valeur de nt:")
            self.t = input()
    
    def update_data(self):
        self.affichage.N = int(self.var[5])
        self.affichage.DT = int(self.var[6])
        self.affichage.NT = int(self.var[7])
        self.affichage.t = int(self.t)
        self.affichage.L = float(self.var[0])

be_fortran = application()
be_fortran.run()