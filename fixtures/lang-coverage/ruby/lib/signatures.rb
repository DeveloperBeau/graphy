# feature: NAME-ONLY typed-layer fixture. A module-level function and an
# instance method, each with parameters. Ruby's grammar carries no type
# annotations, so the signature layer records parameter names only.

module Mailer
  def self.deliver(recipient, subject = "hi", *attachments)
    [recipient, subject, attachments]
  end
end

class Inbox
  def archive(message, folder)
    [message, folder]
  end
end
