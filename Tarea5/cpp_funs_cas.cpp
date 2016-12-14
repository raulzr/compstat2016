#include <RcppArmadillo.h>   
// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
double logapriori_a(double a, double mean_a,double sd_a){
  // Se llama a R y usa rnorm con parámetro 1 (log)
  return R::dnorm(a,mean_a,sd_a,1);
}

// [[Rcpp::export]]
double logapriori_b(double b, double mean_b,double sd_b){
  // Se llama a R y usa rnorm con parámetro 1 (log)
  return R::dnorm(b,mean_b,sd_b,1);
}


// [[Rcpp::export]]
double logapriori_sigma2(double sigma2, double shape_sigma2,double scale_sigma2){
  // apriori sigma2
  return R::dgamma(sigma2,shape_sigma2,scale_sigma2,1);
}

// [[Rcpp::export]]
double log_AP(NumericVector theta,
              double mean_a,
              double sd_a,
              double mean_b,
              double sd_b,
              double shape_sigma2,
              double scale_sigma2
)
{ double a = theta[0];
  double b = theta[1];
  double sigma2 = theta[2];
  
  return logapriori_a(a,mean_a,sd_a) 
    + logapriori_b(b, mean_b, sd_b) 
    + logapriori_sigma2(sigma2, shape_sigma2, scale_sigma2);
}

// [[Rcpp::export]]
double log_LH(NumericVector theta, NumericVector X, NumericVector Y)
{
  double a = theta[0];
  double b = theta[1];
  double sigma2 = theta[2];
  int n = X.size();
  NumericVector error(n);
  for (int i=0; i < n; i++)
  {
    error[i] = Y[i]-(X[i]*b+a);
  }
  
  double log_LH =0;
  for (int i=0; i < n; i++)
  {
    log_LH += log(R::dnorm(error[i],0,sqrt(sigma2),0));
  }
  return log_LH;
}

// [[Rcpp::export]]
double log_POS(NumericVector theta,
               NumericVector X,
               NumericVector Y,
               double mean_a,
               double sd_a,
               double mean_b,
               double sd_b,
               double shape_sigma2,
               double scale_sigma2)
{
  return log_AP(theta, mean_a, sd_a, mean_b, sd_b, shape_sigma2, scale_sigma2)
  + log_LH(theta,X,Y);
}

// [[Rcpp::export]]
NumericVector run_mcmc(
    int n_sim,
    NumericVector theta0,
    NumericVector X,
    NumericVector Y,
    double jump,
    double mean_a,
    double sd_a,
    double mean_b,
    double sd_b,
    double shape_sigma2,
    double scale_sigma2)
  
{
  int n_param = theta0.size();
  NumericMatrix sim(n_sim + 1, n_param); // aqui voy a guardar las simulaciones
  NumericVector eta(n_param);
  sim(0,_)=theta0;
  // sim(0,0) = theta0[0];
  // sim(0,1) = theta0[1];
  // sim(0,2) = theta0[2];
  double U;
  bool accepted;
  for (int i=1; i < n_sim; i++) {
    // do while hasta que acepte el candidato
    do {
      eta[0] = (rnorm(1, sim(i-1,0), jump))[0]; //alpha
      eta[1] = (rnorm(1, sim(i-1,1), jump))[0]; //beta
      eta[2] = rnorm(1, sim(i-1,2), jump)[0]; 
      U = (runif(1))[0];
      accepted = (log(U) <= 
        log_POS(eta,X,Y, mean_a, sd_a, mean_b, sd_b, shape_sigma2, scale_sigma2) 
                    - log_POS(sim(i,_),X,Y, mean_a, sd_a, mean_b, sd_b, shape_sigma2, scale_sigma2));
    } while (!accepted);//or menor que max iter
    sim(i,_) = eta;
    
  }
  return sim;
}