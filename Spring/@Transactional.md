# Transaction

## 源码

```java
/*
 * Copyright 2002-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.transaction.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.core.annotation.AliasFor;
import org.springframework.transaction.TransactionDefinition;

/**
 * Describes a transaction attribute on an individual method or on a class.
 *
 * <p>At the class level, this annotation applies as a default to all methods of
 * the declaring class and its subclasses. Note that it does not apply to ancestor
 * classes up the class hierarchy; methods need to be locally redeclared in order
 * to participate in a subclass-level annotation.
 *
 * <p>This annotation type is generally directly comparable to Spring's
 * {@link org.springframework.transaction.interceptor.RuleBasedTransactionAttribute}
 * class, and in fact {@link AnnotationTransactionAttributeSource} will directly
 * convert the data to the latter class, so that Spring's transaction support code
 * does not have to know about annotations. If no rules are relevant to the exception,
 * it will be treated like
 * {@link org.springframework.transaction.interceptor.DefaultTransactionAttribute}
 * (rolling back on {@link RuntimeException} and {@link Error} but not on checked
 * exceptions).
 *
 * <p>For specific information about the semantics of this annotation's attributes,
 * consult the {@link org.springframework.transaction.TransactionDefinition} and
 * {@link org.springframework.transaction.interceptor.TransactionAttribute} javadocs.
 *
 * @author Colin Sampaleanu
 * @author Juergen Hoeller
 * @author Sam Brannen
 * @since 1.2
 * @see org.springframework.transaction.interceptor.TransactionAttribute
 * @see org.springframework.transaction.interceptor.DefaultTransactionAttribute
 * @see org.springframework.transaction.interceptor.RuleBasedTransactionAttribute
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Transactional {

   /**
    * Alias for {@link #transactionManager}.
    * @see #transactionManager
    */
   @AliasFor("transactionManager")
   String value() default "";

   /**
    * A <em>qualifier</em> value for the specified transaction.
    * <p>May be used to determine the target transaction manager,
    * matching the qualifier value (or the bean name) of a specific
    * {@link org.springframework.transaction.PlatformTransactionManager}
    * bean definition.
    * @since 4.2
    * @see #value
    */
   @AliasFor("value")
   String transactionManager() default "";

   /**
    * The transaction propagation type.
    * <p>Defaults to {@link Propagation#REQUIRED}.
    * @see org.springframework.transaction.interceptor.TransactionAttribute#getPropagationBehavior()
    */
   Propagation propagation() default Propagation.REQUIRED;

   /**
    * The transaction isolation level.
    * <p>Defaults to {@link Isolation#DEFAULT}.
    * <p>Exclusively designed for use with {@link Propagation#REQUIRED} or
    * {@link Propagation#REQUIRES_NEW} since it only applies to newly started
    * transactions. Consider switching the "validateExistingTransactions" flag to
    * "true" on your transaction manager if you'd like isolation level declarations
    * to get rejected when participating in an existing transaction with a different
    * isolation level.
    * @see org.springframework.transaction.interceptor.TransactionAttribute#getIsolationLevel()
    * @see org.springframework.transaction.support.AbstractPlatformTransactionManager#setValidateExistingTransaction
    */
   Isolation isolation() default Isolation.DEFAULT;

   /**
    * The timeout for this transaction (in seconds).
    * <p>Defaults to the default timeout of the underlying transaction system.
    * <p>Exclusively designed for use with {@link Propagation#REQUIRED} or
    * {@link Propagation#REQUIRES_NEW} since it only applies to newly started
    * transactions.
    * @see org.springframework.transaction.interceptor.TransactionAttribute#getTimeout()
    */
   int timeout() default TransactionDefinition.TIMEOUT_DEFAULT;

   /**
    * A boolean flag that can be set to {@code true} if the transaction is
    * effectively read-only, allowing for corresponding optimizations at runtime.
    * <p>Defaults to {@code false}.
    * <p>This just serves as a hint for the actual transaction subsystem;
    * it will <i>not necessarily</i> cause failure of write access attempts.
    * A transaction manager which cannot interpret the read-only hint will
    * <i>not</i> throw an exception when asked for a read-only transaction
    * but rather silently ignore the hint.
    * @see org.springframework.transaction.interceptor.TransactionAttribute#isReadOnly()
    * @see org.springframework.transaction.support.TransactionSynchronizationManager#isCurrentTransactionReadOnly()
    */
   boolean readOnly() default false;

   /**
    * Defines zero (0) or more exception {@link Class classes}, which must be
    * subclasses of {@link Throwable}, indicating which exception types must cause
    * a transaction rollback.
    * <p>By default, a transaction will be rolling back on {@link RuntimeException}
    * and {@link Error} but not on checked exceptions (business exceptions). See
    * {@link org.springframework.transaction.interceptor.DefaultTransactionAttribute#rollbackOn(Throwable)}
    * for a detailed explanation.
    * <p>This is the preferred way to construct a rollback rule (in contrast to
    * {@link #rollbackForClassName}), matching the exception class and its subclasses.
    * <p>Similar to {@link org.springframework.transaction.interceptor.RollbackRuleAttribute#RollbackRuleAttribute(Class clazz)}.
    * @see #rollbackForClassName
    * @see org.springframework.transaction.interceptor.DefaultTransactionAttribute#rollbackOn(Throwable)
    */
   Class<? extends Throwable>[] rollbackFor() default {};

   /**
    * Defines zero (0) or more exception names (for exceptions which must be a
    * subclass of {@link Throwable}), indicating which exception types must cause
    * a transaction rollback.
    * <p>This can be a substring of a fully qualified class name, with no wildcard
    * support at present. For example, a value of {@code "ServletException"} would
    * match {@code javax.servlet.ServletException} and its subclasses.
    * <p><b>NB:</b> Consider carefully how specific the pattern is and whether
    * to include package information (which isn't mandatory). For example,
    * {@code "Exception"} will match nearly anything and will probably hide other
    * rules. {@code "java.lang.Exception"} would be correct if {@code "Exception"}
    * were meant to define a rule for all checked exceptions. With more unusual
    * {@link Exception} names such as {@code "BaseBusinessException"} there is no
    * need to use a FQN.
    * <p>Similar to {@link org.springframework.transaction.interceptor.RollbackRuleAttribute#RollbackRuleAttribute(String exceptionName)}.
    * @see #rollbackFor
    * @see org.springframework.transaction.interceptor.DefaultTransactionAttribute#rollbackOn(Throwable)
    */
   String[] rollbackForClassName() default {};

   /**
    * Defines zero (0) or more exception {@link Class Classes}, which must be
    * subclasses of {@link Throwable}, indicating which exception types must
    * <b>not</b> cause a transaction rollback.
    * <p>This is the preferred way to construct a rollback rule (in contrast
    * to {@link #noRollbackForClassName}), matching the exception class and
    * its subclasses.
    * <p>Similar to {@link org.springframework.transaction.interceptor.NoRollbackRuleAttribute#NoRollbackRuleAttribute(Class clazz)}.
    * @see #noRollbackForClassName
    * @see org.springframework.transaction.interceptor.DefaultTransactionAttribute#rollbackOn(Throwable)
    */
   Class<? extends Throwable>[] noRollbackFor() default {};

   /**
    * Defines zero (0) or more exception names (for exceptions which must be a
    * subclass of {@link Throwable}) indicating which exception types must <b>not</b>
    * cause a transaction rollback.
    * <p>See the description of {@link #rollbackForClassName} for further
    * information on how the specified names are treated.
    * <p>Similar to {@link org.springframework.transaction.interceptor.NoRollbackRuleAttribute#NoRollbackRuleAttribute(String exceptionName)}.
    * @see #noRollbackFor
    * @see org.springframework.transaction.interceptor.DefaultTransactionAttribute#rollbackOn(Throwable)
    */
   String[] noRollbackForClassName() default {};

}
```

## 事务管理方式

spring支持编程式事务管理和声明式事务管理两种方式。

编程式事务管理使用TransactionTemplate或者直接使用底层的PlatformTransactionManager。对于编程式事务管理，spring推荐使用TransactionTemplate。

声明式事务管理建立在AOP之上的。其本质是对方法前后进行拦截，然后在目标方法开始之前创建或者加入一个事务，在执行完目标方法之后根据执行情况提交或者回滚事务。声明式事务最大的优点就是不需要通过编程的方式管理事务，这样就不需要在业务逻辑代码中掺杂事务管理的代码，只需在配置文件中做相关的事务规则声明(或通过基于@Transactional注解的方式)，便可以将事务规则应用到业务逻辑中。

## 事务隔离级别

- ISOLATION_DEFAULT 默认值，等同于ISOLATION_READ_COMMITTED
- ISOLATION_READ_UNCOMMITTED 隔离级别表示一个事务可以读取另一个事务修改但还没有提交的数据。该级别不能防止脏读，不可重复读和幻读，因此很少使用该隔离级别。比如PostgreSQL实际上并没有此级别。
- ISOLATION_READ_COMMITTED 该隔离级别表示一个事务只能读取另一个事务已经提交的数据。该级别可以防止脏读，这也是大多数情况下的推荐值。
- ISOLATION_REPEATABLE_READ 该隔离级别表示一个事务在整个过程中可以多次重复执行某个查询，并且每次返回的记录都相同。该级别可以防止脏读和不可重复读。
- ISOLATION_SERIALIZABLE 所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻读。但是这将严重影响程序的性能。通常情况下也不会用到该级别。

## 事务传播行为

如果在开始当前事务之前，一个事务上下文已存在，此时有若干选择可以指定一个事务性方法的执行行为。

- PROPAGATION_REQUIRED 当前存在事务，则加入该事务，不存在则创建一个新的事务
- PROPAGATION_REQUIRES_NEW 创建一个新的事务，如果当前存在事务，则把当前事务挂起。
- PROPAGATION_SUPPORTS 如果当前存在事务，则加入该事务；如果当前没有事务，则以非事务的方式继续运行。
- PROPAGATION_NOT_SUPPORTED 以非事务方式运行，如果当前存在事务，则把当前事务挂起。
- PROPAGATION_NEVER 以非事务方式运行，如果当前存在事务，则抛出异常。
- PROPAGATION_MANDATORY 如果当前存在事务，则加入该事务；如果当前没有事务，则抛出异常。
- PROPAGATION_NESTED 如果当前存在事务，则创建一个事务作为当前事务的嵌套事务来运行；如果当前没有事务，则该取值等价于TransactionDefinition.PROPAGATION_REQUIRED。

## 事务回滚规则

**默认情况下**，如果被注解的数据库操作方法中发生了unchecked异常，所有的数据库操作将rollback；如果发生的异常是checked异常，默认情况下数据库操作还是会提交的。

###### checked异常(Exception)：

表示无效，不是程序中可以预测的。比如无效的用户输入，文件不存在，网络或者数据库链接错误。这些都是外在的原因，都不是程序内部可以控制的。 必须在代码中显式地处理。比如try-catch块处理，或者给所在的方法加上throws说明，将异常抛到调用栈的上一层。 继承自java.lang.Exception（java.lang.RuntimeException除外）。

###### unchecked异常(RuntimeException)：

表示错误，程序的逻辑错误。是RuntimeException的子类，比如IllegalArgumentException, NullPointerException和IllegalStateException。 不需要在代码中显式地捕获unchecked异常做处理。 继承自java.lang.RuntimeException

![img](https://user-gold-cdn.xitu.io/2019/6/23/16b837115eaf50eb?imageslim)