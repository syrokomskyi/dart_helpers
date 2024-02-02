/// Constructor for class without parameters.
typedef TBuilder<T> = T Function();

/// Constructor for class with 1 parameter.
typedef T1Builder<T, P1> = T Function(P1);

/// Constructor for class with 2 parameters.
typedef T2Builder<T, P1, P2> = T Function(P1, P2);
