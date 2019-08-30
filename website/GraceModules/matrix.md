---
title: The matrix Module
keywords: matrix, row, column
sidebar: modules_sidebar
permalink: /modules/matrix/
toc: false
folder: Modules
author:
- 'Sophia Weeks'
---

The matrix module implements 2-dimensional matrices, which as far as possible 
conform to the interface for collections.
The *matrix* module object can be imported using `import "matrix" as m`,
for any identifier `m` of your choice. 



## Constructing Matrices

The request `m.matrix⟦T⟧(r, c) → m.MatrixFactory⟦T⟧ ` will return a `MatrixFactory` 
object that can be used to construct matrices  with `r` rows, `c` columns, and elements of 
type `T`.   

`MatrixFactory` objects respond to the following requests.

```
type MatrixFactory⟦T⟧ = interface {
    zeros → Matrix⟦Number⟧
    // a matrix where all values are equal to 0; value(n) is more general
    
    rows(rows: Collection⟦Collection⟦T⟧⟧) → Matrix⟦T⟧
    // a matrix with the collection rows as its rows;
    // throws MatrixDimensionsError if the rows are not all the same size
    
    columns(columns: Collection⟦Collection⟦T⟧⟧) → Matrix⟦T⟧
    // a matrix with the collection columns as its columns;
    // throws MatrixDimensionsError if the columns are not all the same size
    
    value(v:T) → Matrix⟦T⟧
    // a matrix where all values are equal to v

    values(vs: Collection⟦T⟧) → Matrix⟦T⟧
    // a matrix whose values are vs;
    // throws MatrixDimensionsError if vs.size ≠ rows * columns
}

```

## 2-dimensional matrix operations


`Matrix` objects represent 2-dimensional matrices, with the following interface.

```
type Matrix⟦T⟧ = Collection⟦T⟧ & interface {
    size -> Number 
    // returns the number of values in self
    
    numRows → Number
    // returns the number of rows in self
    
    numColumns → Number 
    // returns the number of columns in self
    
    atRow(r:Number) column(c:Number) put (v:T) → Matrix 
    // adds the value 'v' at row r, column c
    // raises BoundsError if index at r,c does not exist
    
    atRow(r:Number) column(c:Number) → T 
    // returns the value at row r, column c
    // raises BoundsError if index at r,c does not exist
    
    atRow(r:Number) column(c:Number) ifAbsent(action:Procedure0) → T 
    // returns the value at row r, column c
    // executes 'action' if index at r,c does not exist
    
    row(r:Number) → Collection⟦T⟧ 
    // returns row r as a collection
    // raises BoundsError if row index r does not exist
    
    column(c:Number) → Collection⟦T⟧
    // returns column c as a collection
    // raises BoundsError if column index c does not exist
    
    rows → Enumerable⟦Enumerable⟦T⟧⟧ 
    // returns an enumerable collection over the rows of the matrix
    
    columns → Enumerable⟦Enumerable⟦T⟧⟧ 
    // returns an enumerable collection over the columns of the matrix
    
    values → Enumerable⟦T⟧
    // returns an enumerable collection over the values of the matrix
    
    +(other:Matrix⟦T⟧) → Matrix⟦T⟧ 
    // returns the value-wise sum of self and other;
    // raises MatrixDimensionsError if the dimensions of other don't match those of 'self'
    
    -(other:Matrix⟦T⟧) → Matrix⟦T⟧ 
    // returns the value-wise difference of two matrices
    // raises MatrixDimensionsError if the dimensions of other don't match those of 'self'
    
    *(other) → Matrix⟦T⟧
    // returns the value-wise product of self and other if the argument other is a matrix; 
    // returns the product of other mapped over all the elements of self if other is a scalar.
    // Raises MatrixDimensionsError if the dimensions of other don't match the dimesions of self
    
    /(other) → Matrix⟦T⟧
    // returns the value-wise quotient of self and other if the argument other is a matrix;
    // returns the quotient of other mapped over all the elements of self if other is a scalar.
    // Raises MatrixDimensionsError if the dimensions of other don't match the dimesions of 'self'
    
    transpose → Matrix⟦T⟧
    // returns the transpose of self
    
    times(other:Matrix⟦T⟧) → Matrix⟦T⟧
    // returns the matrix product of self and other
    // raises MatrixDimensionsError if the dimensions of other are not compatible with the
    // dimensions of self
    
    reshapeWithNumRows(rs:Number) numColumns(cs:Number) → Matrix⟦T⟧
    // redefines the number of rows and columns in self, if compatible with the number of values
    // raises MatrixDimensionsError if the product of the new dimensions is not the same as
    // the product of the current dimensions.
    
    reshapeWithNumRows(rs:Number) numColumns(cs:Number) 
        additionalValues(vs:Collection⟦T⟧) → Matrix⟦T⟧
    // redefines the number of rows and columns in self, 
    // raises MatrixDimensionsError if the product of the new dimensions 
    //   is not equal to the product of the current dimensions plus the size of the additional values
    
    addRow(row:Collection⟦T⟧) at(index:Number) → Matrix⟦T⟧
    // adds a row to the matrix at the specified index; raises MatrixDimensionsError
    // if the length of the row is not equal to the number of columns in self
    
    deleteRow(r:Number) → Matrix⟦T⟧
    // removes the row at the specified index from the matrix
    // raises BoundsError if the index r is not within the number of rows in self
    
    addColumn(column:Collection⟦T⟧) at(index:Number) → Matrix⟦T⟧
    // adds a column to the matrix at the specified index; raises MatrixDimensionsError 
    // if the length of the column is not equal to the number of rows in self
    
    deleteColumn(c:Number) → Matrix⟦T⟧
    // removes the column at the specified index from self
    // raises BoundsError if the index c is not within the number of columns of self
    
    replaceRowAt(r:Number) with(row:Collection⟦T⟧) → Matrix⟦T⟧
    // replaces the row at index r with row. Raises MatrixDimensionsError 
    // if the row.size is not equal to the number of columns in self;
    // raises BoundsError if the index r is not within the number of rows of self
    
    replaceColumnAt(c:Number) with(column:Collection⟦T⟧) → Matrix⟦T⟧
    // replaces the column at index c with the given collection.
    // Raises MatrixDimensionsError if column.size is not equal to the number of rows in self;
    // raises BoundsError if the index c is not within the number of columns of self
    
    copy → Matrix⟦T⟧
    // returns a new matrix with the same values and dimensions as self
}
 
```
