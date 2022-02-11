package com.hex.amaze.application.petstore.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class QueueUtils {

	public static void sendMessage(String queueName, Object object) throws FileNotFoundException, IOException {
		InitialContext ctx;
		ConnectionFactory factory;
		//Queue queue;
		try {
			System.out.println("Entered sendMessage method of QueueUtils");
			ctx = getInitialContext();

			Object tmp = ctx.lookup("ConnectionFactory");

			QueueConnectionFactory qcf = (QueueConnectionFactory) tmp;
			QueueConnection loQueueconnection = qcf.createQueueConnection();
			Queue queue = (Queue) ctx.lookup("/" + queueName);
			QueueSession session = loQueueconnection.createQueueSession(false, QueueSession.AUTO_ACKNOWLEDGE);
			loQueueconnection.start();
			ObjectMessage msg = session.createObjectMessage();

			/*
			 * //System.out.println("Value of Factory : "+(ConnectionFactory)
			 * ctx.lookup("/ConnectionFactory")); factory = (ConnectionFactory)
			 * ctx.lookup("/ConnectionFactory"); //System.out.println("Factory value set");
			 * queue = (Queue) ctx.lookup("/" + queueName); Connection conn =
			 * factory.createConnection(); Session session = conn.createSession(false,
			 * Session.AUTO_ACKNOWLEDGE); conn.start(); ObjectMessage msg =
			 * session.createObjectMessage();
			 */
//			if (object instanceof Transaction) {
//				Transaction obj = (Transaction) object;
//				msg.setObject(obj);
//			}
//			if (object instanceof InterfaceStatistics) {
//System.out.println("Inside object instance of InterfaceStatistics");
//				InterfaceStatistics obj = (InterfaceStatistics) object;
//				msg.setObject(obj);
//			}
//			if (object instanceof CrashReport) {
//				CrashReport obj = (CrashReport) object;
//				msg.setObject(obj);
//			}
			MessageProducer producer = session.createProducer(queue);
			producer.send(msg);
//conn.stop();
			loQueueconnection.close();

		} catch (NamingException e) {
			System.err.println("Exception occured in sendMessage method : " + e);
		} catch (JMSException e) {
			System.err.println("Exception occured in sendMessage method : " + e);
		} catch (FileNotFoundException e) {
			System.err.println("Exception occured in sendMessage method : " + e);
		} catch (IOException e) {
			System.err.println("Exception occured in sendMessage method : " + e);
		}

	}

	private static InitialContext getInitialContext() throws NamingException, FileNotFoundException, IOException {
		Properties prop = new Properties();
		prop.put(Context.INITIAL_CONTEXT_FACTORY, prop.getProperty("Context.INITIAL_CONTEXT_FACTORY"));
		prop.put(Context.URL_PKG_PREFIXES, prop.getProperty("Context.URL_PKG_PREFIXES"));
		prop.put(Context.PROVIDER_URL, prop.getProperty("Context.PROVIDER_URL"));
		return new InitialContext(prop);
	}
}
