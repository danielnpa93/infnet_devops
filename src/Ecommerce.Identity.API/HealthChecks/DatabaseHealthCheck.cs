using EasyNetQ.Logging;
using Ecommerce.Identity.API.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Ecommerce.Identity.API.HealthChecks
{
    public class DatabaseHealthCheck : IHealthCheck
    {
        private readonly ApplicationDbContext _applicationDbContext;

        public DatabaseHealthCheck(ApplicationDbContext applicationDbContext)
        {
            _applicationDbContext = applicationDbContext;
        }
        public Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
        {
            try
            {
               Console.WriteLine("consultando health...");

                if (_applicationDbContext.Database.CanConnect())
                {
                    return Task.FromResult(HealthCheckResult.Healthy("Database is up and running"));
                }


                return Task.FromResult(new HealthCheckResult(context.Registration.FailureStatus, "Database is down"));
            }
            catch
            {

                return Task.FromResult(new HealthCheckResult(context.Registration.FailureStatus, "Database is down"));
            }
            finally
            {
                Console.WriteLine("consultando health fim");
            }
        }
    }
}
