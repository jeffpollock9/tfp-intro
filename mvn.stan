data {
    vector[2] location;
    cov_matrix[2] covariance;
}

transformed data {
    cholesky_factor_cov[2] covariance_tril = cholesky_decompose(covariance);
}

parameters {
    vector[2] x;
}

model {
    x ~ multi_normal_cholesky(location, covariance_tril);
}