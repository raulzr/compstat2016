#include <RcppArmadillo.h>   

// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;

// [[Rcpp::export]]

NumericMatrix mvrnorm(int n, NumericVector mu, NumericMatrix sigma) {// aqui agregé la funcion que permite de simular una normal 3D
  int ncols = sigma.ncol();                                         // no pregunté porque ! porque es una teoria en mathematica bastante difficil
  arma::mat Y = arma::randn(n, ncols);                              // int n: es para saber cuanto resultado quiero por ejemplo si n=2 tenemos como resultado
  return wrap(arma::repmat(as<arma::vec>(mu), 1, n).t() + Y * arma::chol(as<arma::mat>(sigma)));//una matriz (2,3) donde cada columna es una simulacion para un vector
}



// [[Rcpp::export]]
double logapriori_a(double a, double mean_a,double sd_a){
  // Se llama a R y usa rnorm con parÃ¡metro 1 (log)
  return R::dnorm(a,mean_a,sd_a,1);
}

// [[Rcpp::export]]
double logapriori_b(double b, double mean_b,double sd_b){
  // Se llama a R y usa rnorm con parÃ¡metro 1 (log)
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
    log_LH +=R::dnorm(error[i],0,sqrt(sigma2),1);//corregi aqui es mejor de llamar el log directamente al poner 1
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
NumericMatrix run_mcmc(// aqui run_mcmc da un matrix y no un vector
    int n_sim,
    NumericVector theta0,
    NumericVector X,
    NumericVector Y,
    NumericMatrix matrice_jump,// no es suficente de utilizar un real jump tenemos que entregar una matriz (ver camilo_essai.R)
    double mean_a,
    double sd_a,
    double mean_b,
    double sd_b,
    double shape_sigma2,
    double scale_sigma2)
  
{
  int n_param = theta0.size();
  NumericMatrix sim(n_sim + 1, n_param); // aqui voy a guardar las simulaciones
  NumericMatrix eta(1,n_param);//IMPORTANT utilizé la funcion que permite de simular la ley N3 ademas esta funcion da un resultado como 
  sim(0,_)=theta0;             //un matriz (1,3) 
  double U;
  bool accepted;
  for (int i=1; i < n_sim; i++) {
    // do while hasta que acepte el candidato
    do {
      eta=mvrnorm(1,sim(i-1,_),matrice_jump);// cuidado no tenemos utilizar sim(i,_) pero sim(i-1,_) porque al inicio tenemos unicamente sim(0,_)
      U = (runif(1))[0];
      
      
      accepted = (log(U) <= 
        log_POS(eta(0,_),X,Y, mean_a, sd_a, mean_b, sd_b, shape_sigma2, scale_sigma2) 
                    - log_POS(sim(i-1,_),X,Y, mean_a, sd_a, mean_b, sd_b, shape_sigma2, scale_sigma2));
    } while (!accepted);//or menor que max iter
    sim(i,_) = eta;
    
  }
  return sim;
}